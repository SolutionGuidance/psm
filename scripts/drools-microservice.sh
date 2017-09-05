#!/bin/bash
set -ex

function download_and_sha1 {
	base=$(basename $1)
	[ -e $base ] || curl -OL $1
	echo "$2 $base" | sha1sum --quiet -c - || (printf "$base has an unexpected sha1sum: $(sha1sum $base | awk '{print $1}')\n" && exit)
}

# Set up java
sudo yum -y update
sudo yum -y install unzip java-1.6.0-openjdk.x86_64 ant
sudo alternatives --set java /usr/lib/jvm/jre-1.6.0-openjdk.x86_64/bin/java

# Download the jbpm installer
download_and_sha1 "https://downloads.sourceforge.net/project/jbpm/jBPM%205/jbpm-5.4.0.Final/jbpm-5.4.0.Final-installer-full.zip" f96ed9ee2e574325693c8ce5a0ffea76fb0de319
mv jbpm-5.4.0.Final-installer-full.zip jbpm-installer.zip
unzip jbpm-installer.zip
rm jbpm-installer.zip

# Run the jbpm installer
cd jbpm-installer
ant install.demo.noeclipse

# Edit config
local_ip_for_public='inet-address value="${jboss\.bind\.address:127.0.0.1}"'
any_ip='any\-ipv4\-address'
sed -i "s/$local_ip_for_public/$any_ip/g" jboss-as-7.1.1.Final/standalone/configuration/standalone.xml

# Start jbpm
ant start.demo.noeclipse
