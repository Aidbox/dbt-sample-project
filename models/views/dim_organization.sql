{{
     config(
          materialized='incremental',
          unique_key='id'
    )
}}

SELECT id
       , ts
       , {{ aidbox.path('name') }} name
       , {{ aidbox.path('active') }} active
       , {{ aidbox.path('address,0,city') }}  city
       , {{ aidbox.path('address,0,state') }}  state
       , {{ aidbox.path('address,0,country') }}  country
       , {{ aidbox.identifier('synthea') }} synthea_id
       , {{ aidbox.codesystem_code('type', 'organization-type')}} type_code
       , {{ aidbox.codesystem_display('type', 'organization-type')}} type_display
  FROM {{ ref('aidbox', 'Organization') }}

{% if is_incremental() %}
  where ts > (select max(ts) from {{ this }})
{% endif %}