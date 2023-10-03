docker-build:
	docker build -t habitus_notifications_ms .

docker-run:
	docker run -d --name habitus_notifications_ms -p 4050:4050 --env-file .env habitus_notifications_ms