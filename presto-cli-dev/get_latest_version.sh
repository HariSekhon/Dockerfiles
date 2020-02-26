#!/usr/bin/env bash

srcdir="$(dirname "$0")"

"$srcdir/get_presto_versions.sh" | head -n1
