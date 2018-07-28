# This dockerfile initiates set-up for the PSM Wildfly server.
# The script first downloads necessary resources and artifacts,
# then calls the "bin/entrypoint.sh" shell script to set up the
# server and build the PSM application.

# NOTE: As of 6-4-2018, the PSM app runs well on Wildfly 12 but
# not on Wildfly 13 (the version behind the default tag). If PSM
# eventually works on Wildfly 13, the "12.0.0.Final" tag can be 
# removed.
FROM jboss/wildfly:12.0.0.Final

# Set environment variables, used throughout setup by shell scripts.
ENV JBOSS_HOME /opt/jboss/wildfly
ENV JBOSS_CLI ${JBOSS_HOME}/bin/jboss-cli.sh
ENV JBOSS_STANDALONE ${JBOSS_HOME}/standalone
ENV JBOSS_DEPLOYMENTS  ${JBOSS_STANDALONE}/deployments
ENV JBOSS_STANDALONE_XML ${JBOSS_STANDALONE}/configuration/standalone_xml_history
ENV EAR_NAME cms-portal-services.ear
ENV EAR ${JBOSS_DEPLOYMENTS}/${EAR_NAME}
ENV LAUNCH_JBOSS_IN_BACKGROUND true
ENV PWORD psm
ENV DBUSER psm

USER root

# Add Wildfly user 'psm' w/ password of 'psm', mirroring setup.
RUN cd ${JBOSS_HOME} \
		&& bin/add-user.sh ${DBUSER} ${PWORD}

# Download Postgres JDBC driver and stage for deploy. If the driver is updated, 
# the version number on this line should be the only one that needs to be changed.
RUN curl -o ${JBOSS_HOME}/postgresql.jar "https://jdbc.postgresql.org/download/postgresql-42.2.2.jar"

# Load some packages: netcat (nc), PostgreSQL Server, etc
COPY pgdg-centos96-9.6-3.noarch.rpm /
RUN yum localinstall -y /pgdg-centos96-9.6-3.noarch.rpm \
		&& yum install -y nc postgresql10-server \
		&& rm /pgdg-centos96-9.6-3.noarch.rpm

# Install Tini to use as subreaper in Docker container to adopt zombie
# processes.  Basically, the JVM makes a poor PID 1
ENV TINI_SHA 066ad710107dc7ee05d3aa6e4974f01dc98f3888
RUN curl -fL https://github.com/krallin/tini/releases/download/v0.5.0/tini-static -o /bin/tini && chmod +x /bin/tini \
                 && echo "$TINI_SHA /bin/tini" | sha1sum -c -

# Save wildfly contents.  We'll restore them to a data volume later.
# This lets wildfly make its writes in a data volume, which means it
# doesn't have to write to the container's overlayfs.  This lets us
# avoid the dreaded mount bug:
# https://bugs.openjdk.java.net/browse/JDK-8165852
RUN mv /opt/jboss/wildfly /opt/jboss/wildfly.static

# Prepare the configuration scripts that set up the server, build the
# application, and run the whole setup.
COPY bin/* /usr/local/bin/
RUN chmod a+x /usr/local/bin/*

# Expose ports for configuration and app use.
EXPOSE 8443 9990 8080

# Run the entrypoint script, which handles the setup and execution
# of the application.
ENTRYPOINT ["tini", "--", "/usr/local/bin/entrypoint.sh"]
