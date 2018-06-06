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

As of June 6, 2018, the PSM project is midway through migrating database systems to Liquibase. Because of this, there is one additional step required to fully set up the old portions of the database and get it working. Note that once the migration is complete, this step should no longer be necessary.

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

- After running the command, you will be presented with a bash shell inside the database container. The final step is to run this command:

```
$ cat /mnt/psm-app/db/jbpm.sql \
      /mnt/psm-app/db/seed.sql \
  | psql -h localhost -U psm psm
```

After running, the console should display results for a bunch of SQL operations.

At this point, the application should be ready to go. To try the PSM app out, point your browser at [localhost:8080/cms/login](http://localhost:8080/cms/login).

## Installing Docker

### docker.io

Whenever I talk to people who work for Docker, they advise against
running your distro's packaged version of Docker.  The packages just
don't work very well, partly because Docker is still such a
fast-moving target.  In my own experience, those people are correct.

Docker is not in Debian Stable (jessie).  The Debian
[Wiki](https://wiki.debian.org/Docker) advises using the backports
repository, but it probably makes more sense not to.  Even on Debian
Testing (stretch), where Docker is packaged, the packaged version of
`docker.io` doesn't run properly on two of my boxes.  It gives "No
help topic 'create'" errors and refuses to run anything.  I recommend
installing Docker from
[a .deb file](https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce_17.03.1~ce-0~debian-stretch_amd64.deb)
from the Docker website.

Alternatively, if you want to use the Docker `apt-get` repository, see
[this page](https://docs.docker.com/engine/installation/linux/debian/).

### docker-compose

The `docker-compose.yml` file uses version 2 of the configuration
format, which means the version in the Debian stable and testing repos
should be able to handle it.
