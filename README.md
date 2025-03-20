- [Alpcloud Docker Wordpress Nginx](#alpcloud-docker-wordpress-nginx)
  - [Goals:](#goals)
  - [Requirements](#requirements)
    - [Install Orbit](#install-orbit)
    - [Install make](#install-make)
    - [Full sample of commands to install the application without http support](#full-sample-of-commands-to-install-the-application-without-http-support)
    - [Full sample commands to install the application with https support](#full-sample-commands-to-install-the-application-with-https-support)
    - [Installation conditions](#installation-conditions)
  - [Start application](#start-application)
  - [Destroy application (at your own risks)](#destroy-application-at-your-own-risks)
  - [A big thank to posts and projects](#a-big-thank-to-posts-and-projects)

# Alpcloud Docker Wordpress Nginx
- Created At: 03/20/2025
- Created By: bsu <bertrand.souriau@gmail.com>
- Version: 0.1.0

## Goals: 
- [x] Create a wordpress image from separate services using docker.
- [x] Execute a minimum of instructions to create a new application.
- [x] Generate a Let's encrypt certificate to serve application with https support.
- [x] Be able to auto-install wordpress with custom URL and authentication credentials.

## Requirements

### Install Orbit
- Download https://github.com/gulien/orbit/releases

```
curl -Ls -O https://github.com/gulien/orbit/releases/download/v3.3.0/orbit_Linux_x86_64.tar.gz
tar -xzf orbit*.tar.gz orbit
sudo mv ./orbit /usr/local/bin && chmod +x /usr/local/bin/orbit
```

### Install make

```
sudo apt install build-essential
```

### Full sample of commands to install the application without http support

```sh
cd /home/bsu && mkdir alpcloud && cd alpcloud
git clone ssh://git@gitlab.sixbleuets.ovh:2424/paas-alpcloud/alpcloud-docker-wordpress-nginx.git my-alpcloud-project 
cd my-alpcloud-project
cp .example.env .env # Fill in with you environments values
nano .env
make generate_http_conf # Generate a nginx http conf. Required to start a server to request the let's encrypt certificate.
make autoinstall # Build and auto-install wordpress
```

Note: you could also create a new git repository, duplicate the project, generate the nginx http configuration and use it as application to deploy to PAAS solution such as Dokploy or Portainer that do not offer possibility to run commands after cloning the project and before running the `docker compose` command. 

In case you don't use the https support, it is recommended to comment the certbot service in `docker-compose.yml`. 

// FR
Il y aura 2 possibilités de déployer le projet dans ce cas:
1. Déployer le projet sur la solution PAAS de votre choix. Il se lancera sur le port 80 pour l'URL que vous aurez choisi mais Wordpress ne s'installera pas automatiquement. Il faudra se connecter à l'instance Wordpress, aller dans `/var/www/html` et lancer la command `make autoinstall` pour auto-installer wordpress. A prochain déploiement, la commande de base de docker compose suffira. 
2. Si la solution PAAS vous le permet, lancer à la création de l'application la commande `make autoinstall`. Pour tous les autres déploiement à venir, lancer la commande `make start`.
// /FR


### Full sample commands to install the application with https support

```sh
cd /home/bsu && mkdir alpcloud && cd alpcloud
git clone ssh://git@gitlab.sixbleuets.ovh:2424/paas-alpcloud/alpcloud-docker-wordpress-nginx.git my-alpcloud-project 
cd my-alpcloud-project
cp .example.env .env # Fill in with you environments values
nano .env
make generate_http_conf # Generate a nginx http conf. Required to start a server to request the let's encrypt certificate.
make autoinstall # Build and auto-install wordpress
sudo docker compose stop webserver # Stop webserver
make generate_https_conf # Generate a nginx https conf. Required to serve contents with ssl generated certificates
sudo docker compose up -d --force-recreate --no-deps webserver # Restart webserver
```

### Installation conditions

Nginx service must be stopped. Else the certificate won't be create and the webserver (listening to 80:443) will occur an error.
```
sudo systemctl stop nginx.service
sudo systemctl status nginx.service
```

## Start application

```sh
make start
```

## Destroy application (at your own risks)

```sh
make destroy
```

Be careful, it deletes everything ..!

## A big thank to posts and projects
- https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose
- https://github.com/gulien/orbit?tab=readme-ov-file
- https://github.com/thecodingmachine/docker-images-php/blob/v4/utils/Dockerfile.slim.blueprint
- https://github.com/kassambara/wordpress-docker-compose/