SELECT id
       , {{ aidbox.identifier('npi')}} npi
       , {{ aidbox.path('active') }} active
       , {{ aidbox.path('gender') }} gender
       , {{ aidbox.path('address,0,state') }} state
       , {{ aidbox.path('address,0,country') }} country
       , {{ aidbox.path('address,0,city') }} city
  FROM {{ ref('aidbox', 'Practitioner') }}