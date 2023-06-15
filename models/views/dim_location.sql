select   id 
       , {{ aidbox.path("name") }} as name
from {{ ref('aidbox', 'Location')}}

