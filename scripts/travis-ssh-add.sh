#!/bin/bash
set -ex

# This script extracts a specially formatted private SSH key from Travis
# The private key should be pasted directly into travis (including
# BEGIN and END lines.)  Travis will convert line breaks to spaces.

# Set up the known_hosts
echo $CD_SERVER $CD_HOSTKEY >> ~/.ssh/known_hosts
cat ~/.ssh/known_hosts

# Copy the variable to a (soon to be) key file
echo $CD_KEY > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Convert spaces back into line breaks
sed -i -e 's/ /\n/g' ~/.ssh/id_rsa

# Since there were spaces in the header and footer, remove those lines
head -n -4 ~/.ssh/id_rsa > tmp
tail -n +5 tmp > ~/.ssh/id_rsa
rm tmp

# Re-add the header and footer lines
sed -i '1s/^/-----BEGIN RSA PRIVATE KEY-----\n/' ~/.ssh/id_rsa
sed -i -e "\$a-----END RSA PRIVATE KEY-----" ~/.ssh/id_rsa
