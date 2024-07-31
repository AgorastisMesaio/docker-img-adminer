# Adminer docker container

![GitHub action workflow status](https://github.com/AgorastisMesaio/docker-img-adminer/actions/workflows/docker-publish.yml/badge.svg)

This repository contains a `Dockerfile` aimed to create a *base image* to provide a dockerized Adminer service. Adminer is a full-featured database management tool written in PHP. It supports a variety of database systems including MySQL, MariaDB, PostgreSQL, SQLite, Oracle, and MS SQL. Adminer is designed to be a lightweight, efficient, and user-friendly alternative to phpMyAdmin.

## Key Features

- **Lightweight and Fast:** Minimalistic design for quick loading and operation.
- **Single File:** Just one PHP file to deploy.
- **Secure:** Emphasis on security with frequent updates and robust features.
- **Database Support:** Works with multiple database systems.
- **Customizable:** Easily customizable and extendable through plugins.

## Use Cases

- **Local Development:**
  - Quickly spin up a database management interface for local databases.
  - Simplify the development workflow by providing an easy-to-use GUI.

- **Database Administration:**
  - Manage multiple types of databases from a single interface.
  - Perform administrative tasks such as creating and modifying databases, tables, and entries.

- **Data Analysis:**
  - Perform queries and view results directly.
  - Export and import data in various formats for analysis.

- **Education and Training:**
  - Teach database concepts with a practical, hands-on tool.
  - Demonstrate database operations without the need for complex setups.

- **Deployment in CI/CD Pipelines:**
  - Use in continuous integration environments for database schema management.
  - Automate database tasks as part of deployment pipelines.

## Sample `docker-compose.yml`

This is an example where I'm running Adminer, connected to a Postgress DB used in a guacamole service (not shown)

```yaml
### Docker Compose example
volumes:
  ct_postgres_data:
    driver: local

networks:
  my_network:
    name: my_network
    driver: bridge

services:
  ct_adminer:
    image: ghcr.io/agorastismesaio/docker-img-adminer:main
    hostname: adminer
    container_name: ct_adminer
    restart: always
    ports:
      - 8080:8080 # Management console port
    environment:
        ADMINER_DB: guacamole_db
        ADMINER_DRIVER: pgsql
        ADMINER_PASSWORD: password
        ADMINER_SERVER: ct_postgres
        ADMINER_USERNAME: guacamole
        ADMINER_AUTOLOGIN: 1
        ADMINER_NAME: SW Guacamole DB
    networks:
      - my_network

  ct_postgres:
    :

  ct_other_container:
    :

  ct_other_container:
    :
```

- Start your services

```sh
docker compose up --build -d
```

## For developers

If you copy or fork this project to create your own base image.

### Building the Image

To build the Docker image, run the following command in the directory containing the Dockerfile:

```sh
docker build -t your-image/docker-img-adminer:main .
```

### Troubleshoot

```sh
docker run --rm --name ct_adminer --hostname adminer -p 8080:8080 your-image/docker-img-adminer:main
```
