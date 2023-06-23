

SELECT   id::uuid
       , ts

       , ("resource"#>>'{ onset,dateTime }')::date onset 
       , ("resource"#>>'{ abatement,dateTime }')::date abatement
       , ("resource"#>>'{ recordedDate }')::date recorded

       , ("resource"#>>'{ subject,id }')::uuid patient_id
       , ("resource"#>>'{ encounter,id }')::uuid encounter_id 

       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").code')::jsonpath))::text)) code_code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").display')::jsonpath))::text)) code_display 
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.category.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'condition-category' limit 1), '").code')::jsonpath))::text)) category_code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.category.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'condition-category' limit 1), '").display')::jsonpath))::text)) category_display 
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.clinicalStatus.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'condition-clinical' limit 1), '").code')::jsonpath))::text)) clinical_status
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.verificationStatus.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'condition-verstatus' limit 1), '").code')::jsonpath))::text)) verification_status

  FROM "cdrdemo"."dbt_fhir"."Condition"


 WHERE ts > (select max(ts) from "cdrdemo"."dbt"."fact_condition")


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