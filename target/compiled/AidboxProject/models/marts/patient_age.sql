SELECT   age
         , count(id)
    FROM "cdrdemo"."dbt"."dim_patient"
   WHERE alive
         AND age is not null
GROUP BY 1