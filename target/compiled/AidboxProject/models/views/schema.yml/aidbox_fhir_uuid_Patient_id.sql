select id 
      from "cdrdemo"."dbt_fhir"."Patient"  
     where (id)::text NOT SIMILAR TO  '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'