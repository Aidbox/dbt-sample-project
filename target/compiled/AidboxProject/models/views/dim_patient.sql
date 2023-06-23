

  SELECT id
         , ts
         , DATE_PART('year', AGE(date("resource" #>>'{birthDate}'))) age
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'synthea' limit 1), '").value')::jsonpath))::text)) synthea_id
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'ssn' limit 1), '").value')::jsonpath))::text)) ssn
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.identifier ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_identifiers" WHERE alias = 'mrn' limit 1), '").value')::jsonpath))::text)) mrn
         , ("resource" #>>'{gender}' ) gender
         , (COALESCE((("resource"#>>'{deceased, dateTime}')::timestamp > NOW()),
              (not(("resource"#>>'{deceased, boolean}')::boolean)),
              true)) alive
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.extension ? (@.url == "', (SELECT url FROM "cdrdemo"."dbt"."seed_extension" WHERE alias = 'us-race' limit 1), '").extension.valueString')::jsonpath))::TEXT)) race
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.extension ? (@.url == "', (SELECT url FROM "cdrdemo"."dbt"."seed_extension" WHERE alias = 'us-ethnicity' limit 1), '").extension.valueString')::jsonpath))::TEXT)) ethnicity
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.extension ? (@.url == "', (SELECT url FROM "cdrdemo"."dbt"."seed_extension" WHERE alias = 'us-birthsex' limit 1), '").valueCode')::jsonpath))::TEXT)) birthsex
         , ("resource"#>>'{ birthDate }')::date birthdate
         , extract('YEAR' from ("resource"#>>'{ birthDate }')::date) birth_year
         , ("resource"#>>'{ deceased,dateTime }')::date deceased 
         , extract('YEAR' from ("resource"#>>'{ deceased,dateTime }')::date) deceased_year
         , ("resource"#>>'{ address,0,state }') state 
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.maritalStatus.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'MaritalStatus' limit 1), '").code')::jsonpath))::text)) ms_code
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.maritalStatus.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'MaritalStatus' limit 1), '").display')::jsonpath))::text)) ms_display
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.communication.language.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'language' limit 1), '").code')::jsonpath))::text)) language_code
         , (trim('"' FROM (jsonb_path_query_first("resource", concat('$.communication.language.coding ?(@.system=="', (SELECT system FROM "cdrdemo"."dbt"."seed_codesystems" WHERE alias = 'language' limit 1), '").display')::jsonpath))::text)) language_display
    FROM "cdrdemo"."dbt_fhir"."Patient" p


   WHERE ts > (select max(ts) from "cdrdemo"."dbt"."dim_patient")
