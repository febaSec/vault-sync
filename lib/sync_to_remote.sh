sync_to_remote() {
	if [[ -n "$REMOTE_HOST" ]]; then
        	if ssh -i "$SSH_IDEN_FILE" -o StrictHostKeyChecking=no \
			 -o UserKnownHostsFile=/dev/null -o BatchMode=yes \
			 -o ConnectTimeout=5 "$REMOTE_HOST" "ls $REMOTE_DEST" >/dev/null 2>&1 ; then

			if rsync -az -e "ssh -i $SSH_IDEN_FILE -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
                           -o BatchMode=yes -o ConnectTimeout=5" "$BACKUP_DEST" "$REMOTE_HOST:$REMOTE_DEST" >/dev/null 2>&1 ; then
                        	echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] Archive files were synchronize with remote server." >> "$LOG_FILE"
                	else
                        	echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] Rsync failed to copy files to remote server." >> "$LOG_FILE"
                        	tg_notify "‼️  [ERROR] Rsync failed to copy files to remote server [$REMOTE_HOST]."
                	fi
        	else
                	echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] Archive files cannot be syncronize with remote server [$REMOTE_HOST]." >> "$LOG_FILE"
                	tg_notify "‼️  [ERROR] Server [$REMOTE_HOST] is unreachable."
        	fi
	fi
}
