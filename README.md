Github Actions Demo
===================
This repo demonstrates a simple CI build using Makefile and Github Actions  
All of the operations of a common CI can be executed locally using Makefile  
The Make targets are then chained together in the Github Actions  



The demo app
------------
`/app` contains a simple REST API flash app that doles out the data in `/data`

Example API endpoints:
- `/things`: List all things
- `/things/<id>`: List specific thing



Local Development and Testing
-----------------------------
All development commands can be found in the `Makefile`
Use `pipenv` to wrap virtualenv/pip/pyenv

- requires: 
    - `make` - should be installed on OSX, Linux, WSL by default
    - `pipenv` https://github.com/pypa/pipenv#installation
    - `pyenv` https://github.com/pyenv/pyenv#installation
- Install using pipenv
    - `make install`
- Run the server in development mode
    - `make run`
- Run the unit tests
    - `make unit`
- Update/Install packages with Pipenv
    - `pipenv install <your_package_here>`
- After changing/upgrading python packages update requirements.txt
    - `make freeze`



Container Build and Testing
---------------------------
All build test commands can be found in the `Makefile`  
tl:dr run `make dtest` to to build, run, test, then kill the container

- About the container
    - This container is based on hub.docker.com/_/python
    - The Dockerfile can be found at [./Dockerfile](./Dockefile)
    - Instead of using the Flask development server, we serve the app using Gunicorn with 4 workers
- Run the unit tests in a container
    - `make dunit`
- Build the container
    - `make dbuild`
- Run the container
    - `make drun`
- Curl the app's main endpoint to verify it's online
    - `make dcurl`
- Make sure to teardown afterwards
    - `make dkill`


CI - Github Actions
-------------------
CI is run on push/merge to the master branch
- ci file can be found at [./.github/workflows/ci.yaml](./.github/workflows/ci.yaml)



TODO
----
- Extend this example using an AWS workflow that pushes to AWS ECR and updates an AWS Task Definition
    - for example: https://github.com/actions/starter-workflows/blob/master/ci/aws.yml