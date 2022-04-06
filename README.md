# Sample - PCF Docker build

Repo containing a basic PCF control/solution that can be built using a Docker container.


## How to build in docker?
Prerequisites:
- Docker installed / configured
- Ability to run sh scripts

Steps:
1. Clone the repo
2. Open the root folder of the repo in a terminal
3. Run `./build_docker.sh`

Notes:
- Initial build will be slow, it is setting things up
   ![Initial build is slow](./img/01_initial_build.png)
- Subsequent builds will be faster thanks to docker caching
   ![Subsequent builds are faster](./img/02_subsequent_build.png)


## How to build locally?
Prerequisites:
- Docker installed / configured
- Ability to run sh scripts

Steps:
1. Clone the repo
2. Open the root folder of the repo in a terminal
3. Run `./build_local.sh`


## Get the solution file
- Open the `./dist` folder, solution will be in there
  ![Solution in dist folder](./img/03_solution_in_dist.png)
