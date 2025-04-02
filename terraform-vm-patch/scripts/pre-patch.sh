#!/bin/bash

# Log start time
echo "Starting pre-patch apt update at $(date)"

# Update package information
export DEBIAN_FRONTEND=noninteractive
apt update -y

# Log completion
echo "Completed apt update at $(date)"

# Exit with success
exit 0
