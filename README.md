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

### 3 - Running Magento 2

Before running this from this repository root:
- Make sure no services are running on port 80
- Open `magento2/docker-compose.yml` and add your `COMPOSER_AUTH` keys
- then:
```bash
	cd magento2
	git clone git@github.com:Nosto/nosto-magento2.git
	docker-compose up -d
```
[NOTE]: Magento should be available on `magento2.dev.nos.to:8081` if traefik is running.

Admin credentials are:
User: `admin`
Password:`Admin12345`

### 4 - Running Prestashop
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