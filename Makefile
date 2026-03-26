.PHONY: deploy logs stop clean

deploy:
	git pull
	docker compose pull
	docker compose up --build
	docker image prune -f

logs:
	docker compose logs -f

stop:
	docker compose down

clean:
	docker compose down -v
	docker image prune -af
