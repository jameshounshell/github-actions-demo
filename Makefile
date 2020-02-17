# run test suite
unit:
	docker run --rm  \
	-v $(shell pwd):/workspace \
	--workdir /workspace \
	python:3.7.6-buster \
	bash -c 'pip install -r requirements.txt; python tests.py'


# run the container in detached mode
run:
	docker run --name voteshield -p 5000:5000 -d voteshield

# jump into the continer for debugging
enter:
	docker exec -it voteshield bash

# remove the container
kill:
	docker rm -f voteshield | true

# build the container
build:
	docker build -t voteshield .

# smoke test to see if the server is running
curl:
	curl localhost:5000/

# check the flask logs
logs:
	docker logs voteshield

sleep:
	sleep 2

# do a fresh build and run smoke test
dtest: kill build run sleep logs curl