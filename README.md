# Docker-platforms

### 1 - Before running any platform

Create the default network that will be used by traefik
```bash
docker network create platforms
```
### 2 - Starting up Traefik

Make sure you have created the default external network
```bash
	cd traefik
	docker-compose up -d
```

### 3 - Running Prestashop
```bash
	cd prestashop
	git clone git@github.com:Nosto/nosto-prestashop.git
	docker-compose up -d
```
[NOTE]: Prestashop should be available on `prestashop.dev.nos.to:8081` if traefik is running.
Admin credentials are:
User: `admin@admin.com`
Password:`Admin12345`
Backend URL: `http://prestashop.dev.nos.to:8081/adminn0st0`

### 4 - Running Shopware 5
```bash
	cd shopware
	git clone git@github.com:Nosto/nosto-shopware.git
	docker-compose up -d
```
