#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2016-12-23 10:03:28 +0000 (Fri, 23 Dec 2016)
#
#  https://github.com/HariSekhon/Dockerfiles
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/HariSekhon
#

# base rabbitmq also uses set -eu
set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
#srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)"

export RABBITMQ_ERLANG_COOKIE="${RABBITMQ_ERLANG_COOKIE:-default_cookie}"

# copied from official RabbitMQ docker-entrypoint.sh
if [ "${RABBITMQ_ERLANG_COOKIE:-}" ]; then
    cookieFile='/var/lib/rabbitmq/.erlang.cookie'
    if [ -e "$cookieFile" ]; then
        if [ "$(cat "$cookieFile" 2>/dev/null)" != "$RABBITMQ_ERLANG_COOKIE" ]; then
            echo >&2
            echo >&2 "warning: $cookieFile contents do not match RABBITMQ_ERLANG_COOKIE"
            echo >&2
        fi
    else
        echo "$RABBITMQ_ERLANG_COOKIE" > "$cookieFile"
        chmod 600 "$cookieFile"
    fi
fi

if [ -n "${RABBITMQ_MANAGEMENT_PLUGIN:-}" ]; then
    echo "enabling RabbitMQ management plugin"
    rabbitmq-plugins enable rabbitmq_management --offline
fi

if [ -n "${RABBITMQ_FEDERATION_PLUGIN:-}" ]; then
    echo "enabling RabbitMQ federation plugin"
    rabbitmq-plugins enable rabbitmq_federation --offline
fi

if [ -n "${RABBITMQ_FEDERATION_MANAGEMENT_PLUGIN:-}" ]; then
    echo "enabling RabbitMQ federation management plugin"
    rabbitmq-plugins enable rabbitmq_federation_management --offline
fi

if [ -n "${RABBITMQ_SHOVEL_PLUGIN:-}" ]; then
    echo "enabling RabbitMQ shovel plugin"
    rabbitmq-plugins enable rabbitmq_shovel --offline
fi

if [ -n "${RABBITMQ_SHOVEL_MANAGEMENT_PLUGIN:-}" ]; then
    echo "enabling RabbitMQ shovel management plugin"
    rabbitmq-plugins enable rabbitmq_shovel_management --offline
fi

if [ "${1:-}" = "rabbitmq-cluster" ]; then
    echo "Starting RabbitMQ to trigger upstream entrypoint to write all official configs out"
    bash -x /usr/local/bin/docker-entrypoint.sh rabbitmq-server -detached
    # tried workaround to standard entrypoint not creating them from env vars but timing startup issue
#    if [ -n "${RABBITMQ_DEFAULT_USER:-}" ] &&
#       [ -n "${RABBITMQ_DEFAULT_PASS:-}" ]; then
#        rabbitmqctl add_user "$RABBITMQ_DEFAULT_USER" "$RABBITMQ_DEFAULT_PASS" || :
#        rabbitmqctl set_user_tags "$RABBITMQ_DEFAULT_USER" administrator || :
#    fi
    rabbitmqctl stop
    sleep 2
    echo "Now starting RabbitMQ cluster"
    /usr/local/bin/docker-entrypoint.sh /rabbitmq-cluster
elif [ $# -gt 0 ]; then
    /usr/local/bin/docker-entrypoint.sh "$@"
fi
