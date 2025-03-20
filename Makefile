start:
	docker compose up -d --build

healthcheck:
	docker compose run --rm healthcheck

down:
	docker compose down

install: start healthcheck

configure:
	docker compose -f docker-compose.yml -f wp-auto-config.yml run --rm wp-auto-config

autoinstall: start
	docker compose -f docker-compose.yml -f wp-auto-config.yml run --rm wp-auto-config

clean: down
	@echo "💥 Removing related folders/files..."
	@rm -rf  wordpress/*

reset: clean

destroy: clean
	@echo "💥 Removing related folders/files, docker containers, networks and volumes"
	docker compose rm --all --volumes

generate_http_conf:
	orbit run generate_nginx_http_conf

generate_https_conf:
	orbit run generate_nginx_https_conf