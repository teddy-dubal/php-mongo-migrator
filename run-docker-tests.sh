#!/bin/bash

CURRENT_DIR=$(dirname $(readlink -f $0))

docker-compose -f $CURRENT_DIR/docker/compose.yml up -d

mongoVersions=("34" "429")

for mongoVersion in ${mongoVersions[@]}; do
    echo -e "\n\n\033[1;33m##### Executing test for Mongo v.$mongoVersion\033[0m"
    docker-compose -f $CURRENT_DIR/docker/compose.yml exec php749 bash -c "export PHPMONGO_DSN=mongodb://mongodb$mongoVersion; /phpmongo/vendor/bin/phpunit -c /phpmongo/tests/phpunit.xml /phpmongo/tests"
done
