SELECT   "cdrdemo"."dbt"."dim_organization".name organization
         , "cdrdemo"."dbt"."dim_organization".id organization_id
         , "cdrdemo"."dbt"."dim_location".name location_name
         , "cdrdemo"."dbt"."dim_location".state state
         , "cdrdemo"."dbt"."fact_encounter".class class
         , "cdrdemo"."dbt"."fact_encounter".type_code type_code
         , "cdrdemo"."dbt"."fact_encounter".type_display type_display
         , date_trunc('month', date ("cdrdemo"."dbt"."fact_encounter".start)) date
         , avg("cdrdemo"."dbt"."fact_encounter".duration) duration
         , round(extract(epoch from (avg("cdrdemo"."dbt"."fact_encounter".duration)))/60) duration_minutes
         , count(*)
    FROM "cdrdemo"."dbt"."fact_encounter"
    JOIN "cdrdemo"."dbt"."dim_organization" on "cdrdemo"."dbt"."fact_encounter".organization_synthea_id = "cdrdemo"."dbt"."dim_organization".synthea_id
    JOIN "cdrdemo"."dbt"."dim_location"     on "cdrdemo"."dbt"."fact_encounter".location_synthea_id = "cdrdemo"."dbt"."dim_location".synthea_id
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8