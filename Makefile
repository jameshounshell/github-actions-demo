run:
	docker run --name voteshield -e FLASK_ENV=development --network host -p 5000:5000 -d voteshield

enter:
	docker exec -it voteshield bash

kill:
	docker rm -f voteshield

build:
	docker build -t voteshield .

curl:
	curl localhost:5000/