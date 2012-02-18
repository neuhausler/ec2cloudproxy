#!/bin/sh
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin
cd `dirname $0`
run_erl -daemon /usr/local/var/run/cloudproxy/ /usr/local/var/log/cloudproxy/ "exec erl -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -s reloader -s cloudproxy"
