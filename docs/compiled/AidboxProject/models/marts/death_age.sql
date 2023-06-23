SELECT extract('year' FROM age(deceased, birthdate)) death_age
         , count(id) count
    FROM "cdrdemo"."dbt"."dim_patient"
   WHERE NOT alive
         AND deceased is not null
         AND birthdate is not null
GROUP BY 1