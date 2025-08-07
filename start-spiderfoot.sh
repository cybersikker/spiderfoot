#!/bin/sh

# SpiderFoot startup script for containerized environments
# This script handles environment variables and ensures proper startup

set -e

# Set default values if not provided
export SPIDERFOOT_HOST=${SPIDERFOOT_HOST:-0.0.0.0}
export SPIDERFOOT_PORT=${SPIDERFOOT_PORT:-5001}
export SPIDERFOOT_DEBUG=${SPIDERFOOT_DEBUG:-false}

# Create necessary directories with proper permissions
mkdir -p /var/lib/spiderfoot/log
mkdir -p /var/lib/spiderfoot/cache
chown -R spiderfoot:spiderfoot /var/lib/spiderfoot

# Set debug mode if requested
DEBUG_FLAG=""
if [ "$SPIDERFOOT_DEBUG" = "true" ]; then
    DEBUG_FLAG="-d"
fi

echo "Starting SpiderFoot on ${SPIDERFOOT_HOST}:${SPIDERFOOT_PORT}"
echo "Debug mode: ${SPIDERFOOT_DEBUG}"

# Start SpiderFoot with the configured host and port
exec /opt/venv/bin/python sf.py -l "${SPIDERFOOT_HOST}:${SPIDERFOOT_PORT}" ${DEBUG_FLAG}
