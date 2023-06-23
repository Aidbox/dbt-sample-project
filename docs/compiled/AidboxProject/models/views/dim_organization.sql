

SELECT id
       , ts
       , ("resource"#>>'{ name }') name
       , ("resource"#>>'{ active }') active
       , ("resource"#>>'{ address,0,city }')  city
       , ("resource"#>>'{ address,0,state }')  state
       , ("resource"#>>'{ address,0,country }')  country
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'synthea' limit 1), '").value')::jsonpath))::text)) synthea_id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").code')::jsonpath))::text)) type_code
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.type.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'organization-type' limit 1), '").display')::jsonpath))::text)) type_display
  FROM "cdrdemo"."dbt_fhir"."Organization"


  where ts > (select max(ts) from "cdrdemo"."dbt"."dim_organization")
