#!/bin/sh

if [ "x$WILDFLY_HOME" = "x" ]; then
    WILDFLY_HOME="/opt/wildfly"
fi

if [ "x$WILDFLY_MODE" = "xdomain" ]; then
    echo 'Starting Wildfly in domain mode.'
    $WILDFLY_HOME/bin/domain.sh  --domain-config=$WILDFLY_CONFIG --host-config=$WILDFLY_HOST_CONFIG $WILDFLY_OPTS >> /opt/logs/wildfly-host/server-`date +%Y-%m-%d`.log
else
    echo 'Starting Wildfly in standalone mode.'
    $WILDFLY_HOME/bin/standalone.sh -c $2 -b $3 >> /opt/logs/wildfly-host/server-`date +%Y-%m-%d`.log
fi
