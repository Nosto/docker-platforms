# Docker-platforms - Prestashop

### 1 - Running for the first time
```bash
    ./run.sh
```
This script will clone the necessary repository and build the necessary docker images to start the containers.
The base image for prestashop 1.7 is available on the Dockerfile within this directory. 
For prestashop 8, there is an official image provided (see docker-compose-8.1.yml).

To get IDE completion, the script will run a docker copy command after the image is ready and place them at `prestashop_root`

This will take a while to finish, and only after prestashop has been completely installed and the Nosto extension enabled, you'll see the shop on the browser. 

You can follow the prestashop container logs by running:
```bash
    docker composer logs -f prestashop
```
### 2 - Code quality tools

To run the code quality tools, you can run the following commands:
```bash
    docker compose run --rm composer install
    docker compose run --rm phan
    docker compose run --rm phpcs
    docker compose run --rm phing {VERSION}
```
They are defined at `docker-compose.yml`, uncomment when needed, or they'll run by default when you don't pass args to `docker composer up`.

### 3 - IDE completion:
If you're using IDEA, you can set the `prestashop_root` as a source root to get code completion.
Just right click on prestashop_root (and/or prestashop8_root) and select `Mark Directory as` -> `Sources Root`
![img_1.png](img_1.png)
![img.png](img.png)
### 4 - Pointing to local playcart instance
On the `docker-compose.yml`, you can set your local playcart environment.
If you choose to run on a different domain, you can update the following env vars:
```
NOSTO_SERVER_URL
NOSTO_API_BASE_URL
NOSTO_OAUTH_BASE_URL
NOSTO_WEB_HOOK_BASE_URL
NOSTO_IFRAME_ORIGIN
NOSTO_IFRAME_ORIGIN_REGEXP
```
Leaving those empty will point to production by default.

### 5 - Running Prestashop 8
There is a specific compose file for it:
```bash
    docker-compose -f docker-compose-8.1.yml up -d
```

The domain is set to `http://prestashop8.dev.nos.to:8089`

### 6 - Accessing UI

[NOTE]: Prestashop should be available on `prestashop.dev.nos.to:8081`
Admin credentials are:
User: `admin@admin.com`
Password:`Admin12345`
Backend URL: `http://prestashop.dev.nos.to:8081/adminn0st0`
