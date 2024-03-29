up:
	docker-compose up -d
init:
	docker-compose up -d --build
	docker-compose exec --user=www-data app cp -f config/.env.example config/.env
	docker-compose exec --user=www-data app bash -c 'sed -i \
	-e "s/^DEBUG=\"true\"/DEBUG=\"false\"/g" \
	-e "s/^SECURITY_SALT=\"__SALT__\"/SECURITY_SALT=\"$$CAKE_SECURITY_SALT\"/g" \
	-e "s/^DATABASE_HOST=\"127.0.0.1\"/DATABASE_HOST=\"db\"/g" \
	-e "s/^DATABASE_NAME=\"dbname\"/DATABASE_NAME=\"$$MYSQL_DATABASE\"/g" \
	-e "s/^DATABASE_USER=\"dbuser\"/DATABASE_USER=\"$$MYSQL_USER\"/g" \
	-e "s/^DATABASE_PASS=\"dbpassword\"/DATABASE_PASS=\"$$MYSQL_PASSWORD\"/g" \
	config/.env'
	docker-compose exec --user=www-data app cp -f config/app_for_docker.php config/app_local.php
	docker-compose exec --user=www-data app composer install --no-interaction --no-dev
	docker-compose exec --user=www-data app bin/cake migrations migrate
	docker-compose exec --user=www-data app bin/cake execute_all_migrations_and_seeds
	docker-compose exec --user=www-data app bin/cake cache clear_all
	docker-compose exec --user=www-data app bin/cake recreate_admin admin@imo-tikuwa.com password

start:
	docker-compose start
stop:
	docker-compose stop
restart:
	docker-compose restart

redis:
	docker-compose exec redis bash
app:
	docker-compose exec --user=www-data app bash
web:
	docker-compose exec web sh
db:
	docker-compose exec db bash

redis-log:
	docker-compose logs -f redis
app-log:
	docker-compose logs -f app
web-log:
	docker-compose logs -f web
db-log:
	docker-compose logs -f db

redis-list-keys:
	docker-compose exec redis redis-cli keys "*"
app-phpunit:
	docker-compose exec --user=www-data app composer test
app-phpcs:
	docker-compose exec --user=www-data app composer cs-check
app-phpstan:
	docker-compose exec --user=www-data app composer stan
app-check-all:
	@make app-phpunit
	@make app-phpcs
	@make app-phpstan

db-dump:
	bash mysqldump.sh

down:
	docker-compose down
down-all:
	docker-compose down --rmi all --volumes --remove-orphans
