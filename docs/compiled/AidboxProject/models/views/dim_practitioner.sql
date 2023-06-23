SELECT id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'npi' limit 1), '").value')::jsonpath))::text)) npi
       , ("resource"#>>'{ active }') active
       , ("resource"#>>'{ gender }') gender
       , ("resource"#>>'{ address,0,state }') state
       , ("resource"#>>'{ address,0,country }') country
       , ("resource"#>>'{ address,0,city }') city
  FROM "cdrdemo"."dbt_fhir"."Practitioner"