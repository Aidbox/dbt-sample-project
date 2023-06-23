

SELECT   id::uuid
       , ts
       , ("resource"#>>'{ type }') type
       , ("resource"#>>'{ criticality }') criticality
       , ("resource"#>>'{ patient,id }')::uuid patient_id
       , ("resource"#>>'{ recordedDate }')::date recorded
       , COALESCE((trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").code')::jsonpath))::text)), 
                  (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'rxnorm' limit 1), '").code')::jsonpath))::text)))  code_code
       , COALESCE((trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").display')::jsonpath))::text)), 
                  (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'rxnorm' limit 1), '").display')::jsonpath))::text)))  code_display
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.clinicalStatus.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'allergyintolerance-clinical' limit 1), '").code')::jsonpath))::text)) clinical_status
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.verificationStatus.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'allergyintolerance-verstatus' limit 1), '").code')::jsonpath))::text)) verification_status

  FROM "cdrdemo"."dbt_fhir"."AllergyIntolerance"


 WHERE ts > (select max(ts) from "cdrdemo"."dbt"."fact_allergyintolerance")


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