

SELECT id
       , ts
       , ("resource"#>>'{ status }') status
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").code')::jsonpath))::text)) type_code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'SNOMED CT-INT' limit 1), '").display')::jsonpath))::text)) type_display
       , ("resource"#>>'{ class,code }') class
       , ("resource"#>>'{ period,start }') start
       , ("resource"#>>'{ period,end }') end
       , ("resource"#>>'{ subject,id }') patient_id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'synthea' limit 1), '").value')::jsonpath))::text)) synthea_id
       , ("resource"#>>'{ period,end }')::timestamp - ("resource"#>>'{ period,start }')::timestamp duration
       , (substring ("resource"#>>'{ location,0,location,uri }' FROM '.+\|(.+)$')) location_synthea_id
       , (substring ("resource"#>>'{ serviceProvider,uri }' FROM '.+\|(.+)$')) organization_synthea_id
       , (substring ("resource"#>>'{ participant,0,individual,uri }' FROM '.+\|(.+)$')) practitioner_npi
  FROM "cdrdemo"."dbt_fhir"."Encounter"


  WHERE ts > (select max(ts) from "cdrdemo"."dbt"."fact_encounter")
