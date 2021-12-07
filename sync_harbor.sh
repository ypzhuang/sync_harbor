#!/bin/bash

#apt-get install jq

#https://goharbor.io/docs/2.4.0/working-with-projects/using-api-explorer/

#https://${harbor_domain}/devcenter


project_id=2
harbor_domain=registry.domain.com
token=YWRtaW46SFBUaWdmacjEyMw==
registry_domain=registry.domain.com

habor_url=https://${harbor_domain}

echo "Sync repositories from Harbor $harbor_domain to Registry $registry_domain"

length=$(curl -s -H "authorization: Basic ${token}" -k -X GET "${habor_url}/api/repositories?project_id=${project_id}" | jq length)

for (( i=0; i< $length; i++ ))
do
  name=$(curl -s -H "authorization: Basic ${token}" -k -X GET "${habor_url}/api/repositories?project_id=${project_id}" | jq -r ".[$i].name")
  echo "Processing repository $name($((i+1))/$length)..."
  
  tags_length=$(curl -s -H "authorization: Basic ${token}" -k -X GET "${habor_url}/api/repositories/${name}/tags" | jq length)
  for (( j=0; j< $tags_length; j++ )) {
    tag=$(curl -s -H "authorization: Basic ${token}" -k -X GET "${habor_url}/api/repositories/${name}/tags" | jq -r ".[$j].name")
    echo " processing tag($((j+1))/$tags_length) $tag..."
    echo " docker pull ${harbor_domain}/${name}:${tag} "

    docker pull ${harbor_domain}/${name}:${tag}
    docker tag ${harbor_domain}/${name}:${tag} ${registry_domain}/${name}:${tag}

    echo " docker push ${registry_domain}/${name}:${tag} "
    docker push ${registry_domain}/${name}:${tag}
  }
done

echo "Sync Done"