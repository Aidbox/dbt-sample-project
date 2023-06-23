

SELECT   id::uuid
       , ts
       , ("resource"#>>'{ status }') status
       , ("resource"#>>'{ issued }')::timestamp issued
       , ("resource"#>>'{ effective,dateTime }')::timestamp effective
       , ("resource"#>>'{ subject,id }')::uuid patient_id
       , ("resource"#>>'{ encounter,id }')::uuid encounter_id 
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'loinc' limit 1), '").code')::jsonpath))::text)) code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'loinc' limit 1), '").display')::jsonpath))::text)) code_display
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.category.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'observation-category' limit 1), '").code')::jsonpath))::text)) category
       , ("resource"#>>'{ value,Quantity,unit }') unit
       , ("resource"#>>'{ value,Quantity,value }') value 
  FROM "cdrdemo"."dbt_fhir"."Observation"
 WHERE ("resource"#>>'{ value,Quantity }') is not null


   AND ts > (select max(ts) from "cdrdemo"."dbt"."fact_observation_quantity")


-- TODO:
--  + value.Quantity
--  - value.CodeableConcept
--  - component