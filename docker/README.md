# PSM in a Docker container

Installing and standing up the PSM is a multi-step process.  We intend
this docker directory to make this process less onerous.  

The `docker-compose.yml` currently sets up Postgres, creates a db user
named 'psm' with password 'psm' and creates a database named 'psm'.
This database lives in a data volume, so it is separable from the
running postgres container.

Docker also includes a mailcatcher, which is just a dummy SMTP server.
The PSM app needs a way to send mail and this suffices.

Finally, there is the wildfly container.  This container builds the
code it finds in psm-app and deploys the resulting ear file.

There is little setup needed.  If Docker works on your system, just
change to the docker directory and:

    $ docker-compose -p psm up --build

Then point your browser at
[172:20.128.3:8080/cms/login](http://172:20.128.3:8080/cms/login)
		
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

Alternatively, if you want to use the Docker apt-get repository, see
[this page](https://docs.docker.com/engine/installation/linux/debian/).

### docker-compose

The `docker-compose.yml` file uses version 2 of the configuration
format, which means the version in the Debian stable and testing repos
should be able to handle it.
