
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
       , {{ aidbox.path('type')}} type
       , {{ aidbox.path('criticality')}} criticality
       , {{ aidbox.path('patient,id')}}::uuid patient_id
       , {{ aidbox.path('recordedDate')}}::date recorded
       , COALESCE({{ aidbox.codesystem_code('code', 'SNOMED CT-INT')}}, 
                  {{ aidbox.codesystem_code('code', 'rxnorm')}})  code_code
       , COALESCE({{ aidbox.codesystem_display('code', 'SNOMED CT-INT')}}, 
                  {{ aidbox.codesystem_display('code', 'rxnorm')}})  code_display
       , {{ aidbox.codesystem_code('clinicalStatus', 'allergyintolerance-clinical')}} clinical_status
       , {{ aidbox.codesystem_code('verificationStatus', 'allergyintolerance-verstatus')}} verification_status

  FROM {{ ref('aidbox', 'AllergyIntolerance') }}

{% if is_incremental() %}
 WHERE ts > (select max(ts) from {{ this }})
{% endif %}

--  {                                                                                                +
--      "category": [                                                                                +
--          "environment"                                                                            +
--      ],                                                                                           +

--      "reaction": [                                                                                +
--          {                                                                                        +
--              "manifestation": [                                                                   +
--                  {                                                                                +
--                      "text": "Allergic skin rash",                                                +
--                      "coding": [                                                                  +
--                          {                                                                        +
--                              "code": "21626009",                                                  +
--                              "system": "http://snomed.info/sct",                                  +
--                              "display": "Allergic skin rash"                                      +
--                          }                                                                        +
--                      ]                                                                            +
--                  }                                                                                +
--              ]                                                                                    +
--          },                                                                                       +
--          {                                                                                        +
--              "manifestation": [                                                                   +
--                  {                                                                                +
--                      "text": "Sneezing",                                                          +
--                      "coding": [                                                                  +
--                          {                                                                        +
--                              "code": "76067001",                                                  +
--                              "system": "http://snomed.info/sct",                                  +
--                              "display": "Sneezing"                                                +
--                          }                                                                        +
--                      ]                                                                            +
--                  }                                                                                +
--              ]                                                                                    +
--          }                                                                                        +
--      ],                                                                                           +
--  }