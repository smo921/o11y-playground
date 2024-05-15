setup_repo:
	mkdir -p data_dir/loki data_dir/vector log_files

build:
	docker compose build

start:
	docker compose up -d

stop:
	docker compose stop

down:
	docker compose down

clean:
	rm -rf data_dir/**/*

env:
	cp example.env .env
