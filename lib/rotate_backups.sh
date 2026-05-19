rotate_backups() {
	deleted_count=0
	while IFS= read -r fl; do
        	[[ -z "$fl" ]] && continue

        	if rm -f "$fl" 2>/dev/null; then
                	deleted_count=$((deleted_count + 1))
        	else
                	echo "$(date '+%Y-%m-%d %H:%M:%S') [WARNING] File [$fl] cannot be deleted" >> "$LOG_FILE"
        	fi
	done < <(find "$BACKUP_DEST" -type f -mtime +"$RETENTION_DAYS")
	echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] [$deleted_count] obsolete files was/were deleted" >> "$LOG_FILE"
}
