

SELECT   id
       , ts
       , ("resource"#>>'{ status }') status
       , ("resource"#>>'{ subject,id }') patient_id
       , ("resource"#>>'{ encounter,id }') encounter_id 
       , ("resource"#>>'{ performed,Period,start }')::date start 
       , (substring ("resource"#>>'{ location,uri }' FROM '.+\|(.+)$')) location_synthea_id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").code')::jsonpath))::text)) type_code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.code.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").display')::jsonpath))::text)) type_display
       , ("resource"#>>'{ performed,Period,end }')::timestamp - ("resource"#>>'{ performed,Period,start }')::timestamp duration
  FROM "cdrdemo"."dbt_fhir"."Procedure"

WHERE ts > (select max(ts) from "cdrdemo"."dbt"."fact_procedure")