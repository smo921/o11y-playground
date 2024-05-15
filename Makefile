setup_repo:
	mkdir -p data_dir/loki data_dir/vector log_files

clean:
	rm -rf data_dir/**/*

env:
	cp example.env .env
