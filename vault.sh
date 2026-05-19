#!/bin/bash
# Set script security
set -euo pipefail
trap 'echo "The error in the line $LINENO"' ERR

# Connect resources
source "lib/check_requirements.sh"
source "lib/perform_backup.sh"
source "lib/rotate_backups.sh"
source "lib/sync_to_remote.sh"
source "src/tg_notify.sh"
source "src/dependencies.sh"
# CHECKS BLOCK
check_requirements

# Archivation
perform_backup

# Rotation: delete archive files that older than $RETENTION_DAYS
rotate_backups

# Synchronization with a remote server
sync_to_remote

# Report and size checking
ARCHIVE_SIZE=$(du -h --apparent-size "$ARCHIVE_PATH" | awk '{print $1}')

echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Backup Successful! File: [$ARCHIVE_NAME], Size: [$ARCHIVE_SIZE], Old backups cleaned." >> "$LOG_FILE"
tg_notify "✅ [INFO] Backup Successful! File: $ARCHIVE_NAME. Size: [$ARCHIVE_SIZE]. Old backups cleaned."
