# Vault-Sync 🛡️📦 (Dockerized)
Vault-Sync is a Dockerized backup automation tool built in Bash. It automates backup tasks such as disk space checks, compressed archiving, file rotation, remote SSH synchronization, and Telegram notifications.

## 🌟 Why this Docker version?
- Zero-Dependency: Runs on any system with Docker support. No need to install `rsync`, `ssh`, or `jq` on your host.
- Containerized Isolation: Source data is mounted as Read-Only (`:ro`), ensuring your original files remain untouched even in case of a script error.
- Isolated SSH: Uses a secure bridge to your host's SSH keys for encrypted offsite transfers.

## 🚀 Quick Start

1. Clone the repository:
```bash
   git clone https://github.com/febaSec/vault-sync.git
   cd vault-sync
```
2. Configure Telegram Credentials:
- Create your credential files in src/:
```bash
  # Add your TG_TOKEN and CHAT_ID
  nano src/tg_creds.env
```
3. Configure SSH Access:
- Ensure your SSH private key exists in ~/.ssh/ and the public key is added to the remote server:
```bash
ssh-copy-id user@remote-host
```
4. Map your directories:
- Open docker-compose.yml and point to your real data:
```bash
  volumes:
    - /path/to/your/data:/app/source:ro      # What to backup
    - /path/to/your/backups:/app/destination # Where to store
```
5. Deploy:
```bash
  docker compose up --build
```

## Features
- Archive compression (.tar.gz)
- Automatic backup rotation
- Rsync sync over SSH
- Telegram notifications
- Disk space monitoring

## Stack
- Bash
- Docker / Docker Compose
- Rsync
- OpenSSH
- Telegram Bot API

## Project Structure
- vault.sh — The orchestrator script.
- lib/ — Functional modules (Backup, Rotation, Remote Sync).
- src/ — Notification libraries and environment configurations.
- Dockerfile — Minimal Alpine-based image (~30MB).

#### Tree
```bash.
├── data
├── docker-compose.yml
├── Dockerfile
├── lib
│   ├── check_requirements.sh
│   ├── perform_backup.sh
│   ├── rotate_backups.sh
│   └── sync_to_remote.sh
├── LICENSE
├── README.md
├── src
│   ├── colors.env
│   ├── dependencies.sh
│   ├── tg_creds.env
│   └── tg_notify.sh
└── vault.sh
```

## 📊 Requirements
- Docker & Docker Compose
- SSH Key-pair (for remote synchronization)

## 📄 License
This project is licensed under the MIT License. For more information read LICENSE.
