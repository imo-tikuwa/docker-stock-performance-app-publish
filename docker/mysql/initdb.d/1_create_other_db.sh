#!/bin/bash -eu

mysql=( mysql --protocol=socket -u root )

"${mysql[@]}" <<-EOSQL
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}_debug;
    GRANT ALL ON ${MYSQL_DATABASE}_debug.* TO '$MYSQL_USER'@'%';
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}_test;
    GRANT ALL ON ${MYSQL_DATABASE}_test.* TO '$MYSQL_USER'@'%';
EOSQL