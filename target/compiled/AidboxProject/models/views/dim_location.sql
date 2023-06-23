select   id 
       , ("resource"#>>'{ name }') as name
       , (trim('"' FROM (jsonb_path_query_first(resource->'managingOrganization', concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'synthea' limit 1), '").value')::jsonpath))::text)) organization_synthea_id
       , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'synthea' limit 1), '").value')::jsonpath))::text)) synthea_id
       , ("resource"#>>'{ status }')  status
       , ("resource"#>>'{ address,city }') city
       , ("resource"#>>'{ address,state }')  state
       , ("resource"#>>'{ address,country }')  country
from "cdrdemo"."dbt_fhir"."Location"