{{
     config(
          materialized='incremental',
          unique_key='id',
          indexes=[ {'columns': ['id']},
                    {'columns': ['ts']}]
    )
}}

SELECT id
       , ts
       , {{ aidbox.path('status')}} status
       , {{ aidbox.codesystem_code('type', 'SNOMED CT-INT')}} type_code
       , {{ aidbox.codesystem_display('type', 'SNOMED CT-INT')}} type_display
       , {{ aidbox.path('class,code') }} class
       , {{ aidbox.path('period,start') }} start
       , {{ aidbox.path('period,end') }} end
       , {{ aidbox.path('subject,id')}} patient_id
       , {{ aidbox.identifier('synthea') }} synthea_id
       , {{ aidbox.path('period,end') }}::timestamp - {{ aidbox.path('period,start') }}::timestamp duration
       , {{ aidbox.identifier_from_uri('location,0,location,uri')}} location_synthea_id
       , {{ aidbox.identifier_from_uri('serviceProvider,uri')}} organization_synthea_id
       , {{ aidbox.identifier_from_uri('participant,0,individual,uri')}} practitioner_npi
  FROM {{ ref('aidbox', 'Encounter') }}

{% if is_incremental() %}
  WHERE ts > (select max(ts) from {{ this }})
{% endif %}