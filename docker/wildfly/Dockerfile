FROM jboss/wildfly
MAINTAINER James Vasile <james@opentechstrategies.com>

ENV JBOSS_HOME /opt/jboss/wildfly
ENV JBOSS_CLI ${JBOSS_HOME}/bin/jboss-cli.sh
ENV JBOSS_STANDALONE ${JBOSS_HOME}/standalone
ENV JBOSS_DEPLOYMENTS  ${JBOSS_STANDALONE}/deployments
ENV JBOSS_STANDALONE_XML ${JBOSS_STANDALONE}/configuration/standalone_xml_history
ENV EAR_NAME cms-portal-services.ear
ENV EAR ${JBOSS_DEPLOYMENTS}/${EAR_NAME}
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER root

# Add Wildfly user 'psm' w/ password of 'psm'
RUN cd ${JBOSS_HOME} \
		&& bin/add-user.sh psm psm

# Download Postgres JDBC driver and stage for deploy
RUN curl -o ${JBOSS_DEPLOYMENTS}/postgresql.jar "https://jdbc.postgresql.org/download/postgresql-42.1.1.jar"

# Load some packages
COPY pgdg-centos96-9.6-3.noarch.rpm /
RUN yum localinstall -y /pgdg-centos96-9.6-3.noarch.rpm \
		&& yum install -y ant nc postgresql96-server \
		&& rm /pgdg-centos96-9.6-3.noarch.rpm

RUN mkdir -p /root/bin

# We touch the file here to use as a newness flag later.  If our
# config is newer than the somewhat randomly-chosen bin/product.conf,
# it indicates we've already done setup.sh.
RUN touch /opt/jboss/wildfly/bin/product.conf

# Save wildfly contents.  We'll restore them to a data volume later.
# This lets wildfly make its writes in a data volume, which means it
# doesn't have to write to the container's overlayfs.  This lets us
# avoid the dreaded mount bug:
# https://bugs.openjdk.java.net/browse/JDK-8165852
RUN mv /opt/jboss/wildfly /opt/jboss/wildfly.static

## Load and prep our cmd script and subsidiary scripts.  That cmd
## script builds the ear file, sets up the server, waits for db and
## mail to come up, then starts the wildfly server.  On subsequent
## runs, it should skip build and setup unless something changes.
COPY bin/* /root/bin/
RUN chmod a+x /root/bin/*

EXPOSE 8443 8080 9990

CMD /root/bin/cmd.sh
