{{
     config(
          materialized='incremental',
          unique_key='id',
          indexes=[{'columns': ['id']},
                   {'columns': ['ts']}]
    )
}}

SELECT   id
       , ts
       , {{ aidbox.path('status')}} status
       , {{ aidbox.path('subject,id')}} patient_id
       , {{ aidbox.path('encounter,id')}} encounter_id 
       , {{ aidbox.path('performed,Period,start')}}::date start 
       , {{ aidbox.identifier_from_uri('location,uri')}} location_synthea_id
       , {{ aidbox.codesystem_code('code', 'SNOMED CT-INT')}} type_code
       , {{ aidbox.codesystem_display('code', 'SNOMED CT-INT')}} type_display
       , {{ aidbox.path('performed,Period,end') }}::timestamp - {{ aidbox.path('performed,Period,start') }}::timestamp duration
  FROM {{ ref('aidbox', 'Procedure') }}

{% if is_incremental() -%}
     WHERE ts > (select max(ts) from {{ this }})
{%- endif %}