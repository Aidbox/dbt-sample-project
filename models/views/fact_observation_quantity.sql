{{
     config(
          materialized='incremental',
          unique_key='id',
          indexes=[{'columns': ['id']},
                   {'columns': ['ts']}]
    )
}}

SELECT   id::uuid
       , ts
       , {{ aidbox.path('status')}} status
       , {{ aidbox.path('issued')}}::timestamp issued
       , {{ aidbox.path('effective,dateTime')}}::timestamp effective
       , {{ aidbox.path('subject,id')}}::uuid patient_id
       , {{ aidbox.path('encounter,id')}}::uuid encounter_id 
       , {{ aidbox.codesystem_code('code', 'loinc')}} code
       , {{ aidbox.codesystem_display('code', 'loinc')}} code_display
       , {{ aidbox.codesystem_code('category', 'observation-category')}} category
       , {{ aidbox.path('value,Quantity,unit')}} unit
       , {{ aidbox.path('value,Quantity,value')}} value 
  FROM {{ ref('aidbox','Observation') }}
 WHERE {{ aidbox.path('value,Quantity')}} is not null

{% if is_incremental() %}
   AND ts > (select max(ts) from {{ this }})
{% endif %}

-- TODO:
--  + value.Quantity
--  - value.CodeableConcept
--  - component