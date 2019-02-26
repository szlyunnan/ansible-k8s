#!/usr/bin/env bash

PROXY=`ps -C haproxy --no-header | wc -l`
if [ ${PROXY} -eq 0 ];then
    systemctl restart {{ HA_SERVER }}
    sleep 3
    if [ `ps -C haproxy --no-header | wc -l ` -eq 0 ];then
        systemctl stop keepalibed
    fi
fi
