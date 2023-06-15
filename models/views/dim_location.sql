select   id 
       , {{ aidbox.path("name") }} as name
       , {{ aidbox.identifier('synthea', "resource->'managingOrganization'") }} organization_synthea_id
       , {{ aidbox.identifier('synthea') }} synthea_id
       , {{ aidbox.path('status') }}  status
       , {{ aidbox.path('address,city') }} city
       , {{ aidbox.path('address,state') }}  state
       , {{ aidbox.path('address,country') }}  country
from {{ ref('aidbox', 'Location')}}