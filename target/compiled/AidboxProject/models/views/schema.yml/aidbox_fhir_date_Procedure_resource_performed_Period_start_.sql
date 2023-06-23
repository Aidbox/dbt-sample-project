select id 
      from "cdrdemo"."dbt_fhir"."Procedure"  
     where (resource#>>'{performed,Period,start}')::text NOT SIMILAR TO  '([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)(-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?)?'