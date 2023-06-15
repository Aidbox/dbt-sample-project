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
         , {{ aidbox.age() }} age
         , {{ aidbox.identifier('synthea') }} synthea_id
         , {{ aidbox.identifier('ssn') }} ssn
         , {{ aidbox.identifier('mrn') }} mrn
         , {{ aidbox.gender() }} gender
         , {{ aidbox.alive() }} alive
         , {{ aidbox.race() }} race
         , {{ aidbox.ethnicity() }} ethnicity
         , {{ aidbox.extension('us-birthsex', 'valueCode') }} birthsex
         , {{ aidbox.path('birthDate') }}::date birthdate
         , extract('YEAR' from {{ aidbox.path('birthDate') }}::date) birth_year
         , {{ aidbox.path('deceased,dateTime') }}::date deceased 
         , extract('YEAR' from {{ aidbox.path('deceased,dateTime') }}::date) deceased_year
         , {{ aidbox.path('address,0,state') }} state 
         , {{ aidbox.codesystem_code('maritalStatus', 'MaritalStatus') }} ms_code
         , {{ aidbox.codesystem_display('maritalStatus', 'MaritalStatus') }} ms_display
         , {{ aidbox.codesystem_code('communication.language', 'language') }} language_code
         , {{ aidbox.codesystem_display('communication.language', 'language') }} language_display
    FROM {{ ref('aidbox', 'Patient') }} p

{% if is_incremental() %}
   WHERE ts > (select max(ts) from {{ this }})
{% endif %}