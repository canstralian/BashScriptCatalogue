# Networking Scripts

This directory contains scripts related to network operations, remote connections, and WiFi management.

## Scripts

### 📡 brute_force_wifi.sh

**Description:** A Python-based script that demonstrates WiFi password brute-forcing concepts using itertools.

**Note:** This is actually a Python script (`.sh` extension notwithstanding). It demonstrates the concept of trying password combinations for educational purposes.

**Usage:**
```python
python brute_force_wifi.sh
```

**Parameters:**
- `network_name`: The SSID of the WiFi network

**Warning:** This script is for educational purposes only. Unauthorized access to networks is illegal.

**Example:**
```python
network_name = '0522195636-eLifeUltra750mbps'
password = brute_force_wifi_password(network_name)
```

---

### 🔄 copy_to_remote_server.sh

**Description:** Copies files from a local directory to a remote server using rsync over SSH.

**Usage:**
```bash
./copy_to_remote_server.sh <source_dir> <destination_dir> <user@remote_server>
```

**Parameters:**
- `$1`: Source directory path on the local machine
- `$2`: Destination directory path on the remote server
- `$3`: Username and IP address of the remote server (format: `user@ip`)

**Prerequisites:**
- SSH access configured to the remote server
- rsync installed on both local and remote machines
- Destination directory must exist on the remote server

**Example:**
```bash
./copy_to_remote_server.sh "/local/path/data" "/remote/path/backup" "user@192.168.1.100"
```

**Features:**
- Validates source directory exists
- Checks if destination directory exists on remote server
- Uses rsync for efficient transfer with compression (`-avz` flags)
- Preserves file permissions and timestamps

## Common Use Cases

- **Remote Backups**: Automate backing up local data to remote servers
- **Data Synchronization**: Keep directories synchronized between local and remote systems
- **Deployment**: Copy application files to production servers

## Security Considerations

- Always use SSH key-based authentication for automated scripts
- Ensure proper file permissions on sensitive data
- Verify destination paths to avoid accidental overwrites
- Consider using VPN for transfers over untrusted networks

## Troubleshooting

**SSH Connection Issues:**
- Verify SSH access: `ssh user@remote_server`
- Check SSH key permissions (should be 600)

**rsync Errors:**
- Ensure rsync is installed: `which rsync`
- Check disk space on remote server
- Verify network connectivity

## Related Scripts

- See `../backup/` for backup-specific scripts
- See `../file-management/` for file operation utilities
