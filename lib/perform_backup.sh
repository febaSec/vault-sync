perform_backup() {
	ARCHIVE_NAME="backup_$(date '+%Y-%m-%d_%H-%M-%S').tar.gz"
	ARCHIVE_PATH="${BACKUP_DEST}/${ARCHIVE_NAME}"
	if tar -czf "$ARCHIVE_PATH" -C "$BACKUP_SOURCE" . >/dev/null 2>&1; then
        	echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] The backup archive [$ARCHIVE_NAME] has been created." >> "$LOG_FILE"
	else
        	echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] The backup archive [$ARCHIVE_NAME] cannot be created" >> "$LOG_FILE"
        	tg_notify "‼️  [ERROR] The backup archive [$ARCHIVE_NAME] cannot be created"
	fi

}
