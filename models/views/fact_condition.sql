
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

       , {{ aidbox.path('onset,dateTime')}}::date onset 
       , {{ aidbox.path('abatement,dateTime')}}::date abatement
       , {{ aidbox.path('recordedDate')}}::date recorded

       , {{ aidbox.path('subject,id')}}::uuid patient_id
       , {{ aidbox.path('encounter,id')}}::uuid encounter_id 

       , {{ aidbox.codesystem_code('code', 'SNOMED CT-INT')}} code_code
       , {{ aidbox.codesystem_display('code', 'SNOMED CT-INT')}} code_display 
       , {{ aidbox.codesystem_code('category', 'condition-category')}} category_code
       , {{ aidbox.codesystem_display('category', 'condition-category')}} category_display 
       , {{ aidbox.codesystem_code('clinicalStatus', 'condition-clinical')}} clinical_status
       , {{ aidbox.codesystem_code('verificationStatus', 'condition-verstatus')}} verification_status

  FROM {{ ref('Condition') }}

{% if is_incremental() %}
 WHERE ts > (select max(ts) from {{ this }})
{% endif %}

-- -------------------------------------------------------------------------------------------
--  {                                                                                        +
--      "onset": {                                                                           +
--          "dateTime": "2004-06-07T09:34:57+00:00"                                          +
--      },                                                                                   +
--      "abatement": {                                                                       +
--          "dateTime": "2005-06-13T10:04:36+00:00"                                          +
--      },                                                                                   +
--      "recordedDate": "2004-06-07T09:34:57+00:00",                                         +
--  }