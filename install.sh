#!/bin/bash

#
# This script installs and configures cloudproxy on a fresh Amazon Linux AMI instance.
# Requires Erlang to be installed
#
# Must be run with root privileges
#

PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin


git clone git://github.com/neuhausler/CloudProxy
cd CloudProxy
make
cd ..
mkdir -p /usr/local/lib/cloudproxy
cp -r CloudProxy/* /usr/local/lib/cloudproxy

# remove old link
rm /usr/local/etc/cloudproxy

ln -s -f /usr/local/lib/cloudproxy/priv /usr/local/etc/cloudproxy
mkdir -p /usr/local/etc/cloudproxy/work
mkdir -p /usr/local/var/log/cloudproxy
mkdir -p /usr/local/var/run/cloudproxy

# copy start-service script
cp start-service.sh /usr/local/lib/cloudproxy/

# copy changed config file
cp cloudproxy.conf /usr/local/lib/cloudproxy/priv/

# put init.d script in place
cp cloudproxy-initd /usr/local/etc/rc.d/cloudproxy
chmod 0755 /usr/local/etc/rc.d/cloudproxy
ln -s /usr/local/etc/rc.d/cloudproxy /etc/init.d/cloudproxy


# done!
echo
echo
echo "Installation complete!"
echo "CloudProxy is ready to start. Run:"
echo "    sudo service cloudproxy start"

