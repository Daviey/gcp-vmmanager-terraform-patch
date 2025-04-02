#!/bin/bash

# Log completion
echo "System update and upgrade completed at $(date)"

# Check if reboot is required
if [ -f /var/run/reboot-required ]; then
  echo "A reboot is required to complete the upgrade"
else
  echo "No reboot is required"
fi

# Exit with success
exit 0
