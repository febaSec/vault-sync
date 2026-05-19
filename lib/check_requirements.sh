check_requirements() {
	mkdir -p /root/.ssh
	chmod 700 /root/.ssh
#	cp /app/.ssh/id_ed25519 /root/.ssh/id_ed25519
	chmod 600 /root/.ssh/id_ed25519


	dependencies
	space=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
	if (( "$space" >= 90 )); then
        	echo "$(date '+%Y-%m-%d %H:%M:%S') [CRITICAL] Not enough free space on the disk. Stop the backup script." >> "$LOG_FILE"
        	tg_notify "‼️  [CRITICAL] Not enough free space. The backup script stopped. Server [$(hostname)]"
        	exit 10
	elif (( "$space" >= 80 )); then
        	echo "$(date '+%Y-%m-%d %H:%M:%S') [WARNING] Free space on the disk is less than 20%." >> "$LOG_FILE"
        	tg_notify "⚠️   [WARNING] Free space on the disk is less than 20%."
	fi
}
