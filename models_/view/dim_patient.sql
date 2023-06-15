 {{ 
     config(
          materialized='incremental',
          unique_key='id',
          indexes=[{'columns': ['id', 'ts']},
                   {'columns': ['birthdate', 'birth_year', 'deceased', 'deceased_year']},
                   {'columns': ['birth_year', 'deceased_year']},
                   {'columns': ['state', 'gender', 'race', 'birthdate', 'ms_display', 'language_display']} ])
  }}

  SELECT id
         , ts
         , {{ age() }} age
         , {{ identifier('synthea') }} synthea_id
         , {{ identifier('ssn') }} ssn
         , {{ identifier('mrn') }} mrn
         , {{ gender() }} gender
         , {{ alive() }} alive
         , {{ race() }} race
         , {{ ethnicity() }} ethnicity
         , {{ extension('us-birthsex', 'valueCode') }} birthsex
         , {{ get('birthDate') }}::date birthdate
         , extract('YEAR' from {{ get('birthDate') }}::date) birth_year
         , {{ get('deceased,dateTime') }}::date deceased 
         , extract('YEAR' from {{ get('deceased,dateTime') }}::date) deceased_year
         , {{ get('address,0,state') }} state 
         , {{ codesystem_code('maritalStatus', 'MaritalStatus') }} ms_code
         , {{ codesystem_display('maritalStatus', 'MaritalStatus') }} ms_display
         , {{ codesystem_code('communication.language', 'language') }} language_code
         , {{ codesystem_display('communication.language', 'language') }} language_display
    FROM {{ ref('Patient') }} p

{% if is_incremental() %}
   WHERE ts > (select max(ts) from {{ this }})
{% endif %}