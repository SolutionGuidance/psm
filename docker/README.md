# Deploying PSM with Docker

Installing and setting up the PSM application locally is a tedious, multi-step process. We provide this Docker configuration as a simpler alternative to the standard PSM installation procedure.

## Overview

`docker-compose.yml` sets up three separate containers:

- Postgres: This container manages the database. It is set up with a database user named 'psm' with password 'psm', and a running database named 'psm'. This database lives in a data volume, so it is separable from the running Postgres container.

- Mailcatcher: Simple container that serves as a dummy SMTP server. The PSM app needs a way to send mail and this suffices.

- Wildfly: This container does the bulk of the work for the PSM application:
    - Sets up a Wildfly instance
    - Configures it to match the standard installation instructions, if not already configured
    - Builds and deploys the code contained in `psm-app`, if a rebuild is necessary
    - Deploys the resulting .ear file
    - Builds the Liquibase database
  
  These tasks are performed in the setup scripts contained in `\wildfly\bin`.

## Build with Docker

Fortunately, there is little setup required. If Docker works on your system, change into the `psm/docker` directory and run:

    $ docker-compose -p psm up --build

This command will build and run the full Docker setup.

### TEMPORARY: Database Configuration

As of June 27, 2018, the PSM project is midway through migrating database systems to Liquibase. Because of this, there is one additional step required to fully set up the old portions of the database and get it working. Note that once the migration is complete, this step should no longer be necessary.

To do this last step, you need to manually connect to the database container and run a single command.

- In a new terminal, run `docker container list`. This will get you a list of all the running containers and their IDs, which should look like this:

```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                                                    NAMES
5908afb4ef5f        psm_wildfly         "tini -- /usr/local/…"   About an hour ago   Up About an hour    0.0.0.0:8080->8080/tcp, 0.0.0.0:8443->8443/tcp, 0.0.0.0:9990->9990/tcp   psm_wildfly_1
76b5ca34475d        psm_mail            "mailcatcher --foreg…"   4 hours ago         Up 3 hours          25/tcp, 0.0.0.0:1080->80/tcp                                             psm_mail_1
2b80cb20d5fc        postgres:alpine     "docker-entrypoint.s…"   4 hours ago         Up 3 hours          5432/tcp                                                                 psm_db_1
```

Find the container ID corresponding to the `postgres:alpine` container and copy it. In this example, that would be `2b80cb20d5fc`.

- Next, connect to the container by running `docker exec -it <container id> /bin/bash`, substituting `<container id>` for the ID you copied before. In this case, the command would look like `docker exec -it 2b80cb20d5fc /bin/bash'`

- After running the command, you will be presented with a bash shell inside the database container. The final step is to run this command inside the container:

```
$ cat /mnt/psm-app/db/jbpm.sql \
      /mnt/psm-app/db/seed.sql \
  | psql -h localhost -U psm psm
```

After running, the console should display results for a bunch of SQL operations.

If the database is updated at any point, this step should be repeated to ensure any new data shows up.

At this point, the application should be ready to go. To try the PSM app out, point your browser at [localhost:8080/cms/login](http://localhost:8080/cms/login). You can log in with username `p1` and password `p1`.

## Running Docker after initial build

Restarting the setup after the initial build is as simple as re-running the original Docker command while in the `psm/docker` directory:

    $ docker-compose -p psm up --build

No additional steps are required to start after initial set-up is done.

## Installing Docker

In general, an installation of the latest version of Docker for your platform should work well. Recent versions should include all the dependencies necessary (docker-compose, etc).

You can find the installation instructions for Docker [here](https://docs.docker.com/install/). A basic installation should be sufficient to get the PSM app running.

The Docker setup was developed and tested on MacOS, but there shouldn't be many platform-specific issues (that's the point of Docker, after all).

## Troubleshooting

### Organization Proxies

If possible, it's recommended to run the Docker build when off any enterprise proxies. It's likely you'll run into issues within certain containers when running over a proxy, even if Docker itself is configured correctly for a proxy.
