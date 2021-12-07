# Sync Repositories of Harbor to a Docker Registory

The [Harbor](https://goharbor.io/) doesn't support to sync repositories to a docker registory with basic auth using htpasswd. Please see [the harbor issue](https://github.com/goharbor/harbor/issues/8211),so I coded this shell script after I found the Harbor [REST API](https://goharbor.io/docs/2.4.0/working-with-projects/using-api-explorer/).

Of course, we can use this shell to sync repositories from a Harbor to any other registory,not just a docker registory.

## Prerequisition
* Install [jq](https://stedolan.github.io/jq/download/)
* Docker login the source Harbor registry and the target registory
* Open the swagger of the source Harbor registry to login and list projects.And you can get the the token from the curl command.
* Modify the below enviroments in the shell script:
```
project_id=2
harbor_domain=habor domain
token=the token from the swagger
registry_domain=domain of the target registory
```

## Run
```
./sync_harbor.sh
```

