# run the dockerized unit tests as the default Make target
default: dunit

# -----------
# development
# -----------
# all development should happen in a virtual environment
# I prefer pipenv for wrapping virtualenv, pyenv, pip
install:
	pipenv install

run:
	pipenv run python app/main.py

unit:
	pipenv run python tests.py

uninstall:
	pipenv --rm

# use this to update the requirements.txt 
# after installing new packages
freeze:
	pipenv run pip freeze > requirements.txt

# ----------------------
# continuous integration
# ----------------------
# all these commands are prefixed with "d" for docker
# even the unit test can be run in docker eleviating 
#   the need for pipenv or virtual env

# run test suite
dunit:
	docker run --rm  \
	-v $(shell pwd):/workspace \
	--workdir /workspace \
	python:3.7.6-buster \
	bash -c 'pip install -r requirements.txt; python tests.py'

# run the container in detached mode
drun:
	docker run --name voteshield -p 5000:5000 -d voteshield


# jump into the continer for debugging
denter:
	docker exec -it voteshield bash

# remove the container
dkill:
	docker rm -f voteshield | true

# build the container
dbuild:
	docker build -t voteshield .

# smoke test to see if the server is running
dcurl:
	curl localhost:5000/
	@printf "\n"

# check the flask logs
dlogs:
	docker logs voteshield

sleep:
	sleep 2

# do a fresh build and run smoke test
dtest: dkill dbuild drun sleep dlogs dcurl
	@docker rm -f voteshield | true # cant run dkill twice
	@echo Finished Container Test