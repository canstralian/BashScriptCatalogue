# Backup Scripts

This directory contains scripts for creating, managing, and maintaining backups of system files and directories.

## Scripts

### 💾 rolling_backup_etc.sh

**Description:** Creates rolling weekly backups of the `/etc` directory for the last 4 weeks, automatically removing older backups.

**Usage:**
```bash
./rolling_backup_etc.sh
```

**Function:**
```bash
createRollingBackups
```

**Features:**
- Maintains 4 weeks of backups (28 days)
- Automatic old backup cleanup
- Date-stamped backup directories
- Incremental backup creation
- Backup existence checking (skips if already exists)

**Configuration:**
```bash
# Default backup directory (edit in script)
local backupDir="/path/to/backup/directory"
```

**Backup Structure:**
```
/path/to/backup/directory/
├── 20240101/  # Week 1
│   └── (etc contents)
├── 20240108/  # Week 2
│   └── (etc contents)
├── 20240115/  # Week 3
│   └── (etc contents)
└── 20240122/  # Week 4
    └── (etc contents)
```

**How It Works:**
1. Checks if backup directory exists (creates if not)
2. Calculates date 4 weeks ago
3. Loops through last 4 weeks
4. Creates backup for each week if not exists
5. Copies `/etc` contents to dated directory
6. Removes backups older than 4 weeks

**Customization Examples:**

**Change backup source:**
```bash
# Backup different directory
cp -R /var/log/* "$backupDir/$backupDate"
```

**Change retention period:**
```bash
# Keep 8 weeks instead of 4
local oldestBackupDate=$(date -d "8 weeks ago" +%Y%m%d)
for ((i = 0; i < 8; i++)); do
```

**Add compression:**
```bash
# Compress backups to save space
tar -czf "$backupDir/$backupDate.tar.gz" /etc/*
```

**Exclude files:**
```bash
# Exclude certain directories
rsync -av --exclude='cache' --exclude='tmp' /etc/ "$backupDir/$backupDate/"
```

## Backup Best Practices

### Planning
- **Identify critical data**: Prioritize configuration files, databases, user data
- **Define RPO/RTO**: Recovery Point Objective and Recovery Time Objective
- **Test regularly**: Verify backups can be restored
- **Document procedures**: Keep restoration instructions updated

### Retention Policies
- **Daily backups**: Keep 7 days
- **Weekly backups**: Keep 4-6 weeks  
- **Monthly backups**: Keep 6-12 months
- **Yearly backups**: Keep 3-7 years (depends on compliance)

### Storage
- **On-site backups**: Fast recovery, vulnerable to local disasters
- **Off-site backups**: Disaster recovery, slower to restore
- **3-2-1 Rule**: 3 copies, 2 different media, 1 off-site

### Security
- **Encrypt backups**: Especially for sensitive data
- **Access control**: Limit who can access/modify backups
- **Integrity checks**: Use checksums to verify backup integrity
- **Audit logs**: Track backup creation and access

## Usage Examples

### Basic Usage
```bash
# Run manually
./rolling_backup_etc.sh

# Verify backups created
ls -la /path/to/backup/directory/
```

### Scheduled Backups with Cron
```bash
# Weekly backup every Sunday at 2 AM
0 2 * * 0 /path/to/rolling_backup_etc.sh >> /var/log/backup.log 2>&1

# Daily backup at 3 AM (modify script for daily retention)
0 3 * * * /path/to/rolling_backup_etc.sh >> /var/log/backup.log 2>&1
```

### Enhanced Script with Notifications
```bash
#!/bin/bash
# backup_with_notification.sh

# Run backup
./rolling_backup_etc.sh

# Check result
if [ $? -eq 0 ]; then
    echo "Backup completed successfully" | mail -s "Backup Success" admin@example.com
else
    echo "Backup failed!" | mail -s "Backup FAILURE" admin@example.com
fi
```

### Backup with Verification
```bash
#!/bin/bash
# backup_and_verify.sh

backupDir="/path/to/backup/directory"
today=$(date +%Y%m%d)

# Run backup
./rolling_backup_etc.sh

# Verify backup
if [ -d "$backupDir/$today" ]; then
    file_count=$(find "$backupDir/$today" -type f | wc -l)
    echo "Backup created with $file_count files"
else
    echo "ERROR: Backup directory not created!"
    exit 1
fi
```

## Advanced Backup Strategies

### Incremental Backups
```bash
#!/bin/bash
# incremental_backup.sh

backup_base="/backups/base"
backup_increment="/backups/incremental"
timestamp=$(date +%Y%m%d_%H%M%S)

# Create base if doesn't exist
if [ ! -d "$backup_base" ]; then
    rsync -av /etc/ "$backup_base/"
fi

# Create incremental backup
rsync -av --link-dest="$backup_base" /etc/ "$backup_increment/$timestamp/"
```

### Differential Backups
```bash
#!/bin/bash
# differential_backup.sh

backup_full="/backups/full/$(date +%Y%m%d)"
backup_diff="/backups/diff/$(date +%Y%m%d_%H%M%S)"

# Full backup on Sundays
if [ $(date +%u) -eq 7 ]; then
    rsync -av /etc/ "$backup_full/"
else
    # Differential backup on other days
    rsync -av --compare-dest="$backup_full" /etc/ "$backup_diff/"
fi
```

### Encrypted Backups
```bash
#!/bin/bash
# encrypted_backup.sh

backup_dir="/backups/encrypted"
timestamp=$(date +%Y%m%d)

# Create compressed backup
tar -czf /tmp/etc_backup.tar.gz /etc/

# Encrypt backup
gpg --encrypt --recipient admin@example.com /tmp/etc_backup.tar.gz

# Move to backup directory
mv /tmp/etc_backup.tar.gz.gpg "$backup_dir/etc_$timestamp.tar.gz.gpg"

# Cleanup
rm /tmp/etc_backup.tar.gz
```

### Remote Backups
```bash
#!/bin/bash
# remote_backup.sh

local_backup="/tmp/etc_$(date +%Y%m%d).tar.gz"
remote_server="user@backup-server.com"
remote_path="/backups/etc/"

# Create compressed backup
tar -czf "$local_backup" /etc/

# Transfer to remote server
scp "$local_backup" "$remote_server:$remote_path"

# Verify transfer
if [ $? -eq 0 ]; then
    echo "Remote backup successful"
    rm "$local_backup"
else
    echo "Remote backup failed"
fi
```

## Restoration Procedures

### Restore Full Backup
```bash
#!/bin/bash
# restore_backup.sh

backup_date="20240115"
backup_dir="/path/to/backup/directory/$backup_date"

# Backup current /etc before restoration
cp -R /etc /etc.backup.$(date +%Y%m%d_%H%M%S)

# Restore from backup
cp -R "$backup_dir"/* /etc/

# Verify restoration
echo "Restoration complete. Please verify system configuration."
```

### Restore Specific Files
```bash
#!/bin/bash
# restore_specific.sh

backup_date="20240115"
backup_dir="/path/to/backup/directory/$backup_date"
file_to_restore="hosts"

# Restore single file
cp "$backup_dir/$file_to_restore" /etc/$file_to_restore

echo "Restored /etc/$file_to_restore from $backup_date"
```

## Troubleshooting

### Common Issues

**Permission Denied:**
```bash
# Run with sudo
sudo ./rolling_backup_etc.sh

# Or add to sudoers for automated execution
```

**Disk Space Issues:**
```bash
# Check available space
df -h /path/to/backup/directory

# Clean old backups manually if needed
rm -rf /path/to/backup/directory/20231201
```

**Backup Incomplete:**
```bash
# Check for errors
./rolling_backup_etc.sh 2>&1 | tee backup.log

# Verify backup integrity
diff -r /etc /path/to/backup/directory/$(date +%Y%m%d)/
```

### Performance Optimization

**Speed up backups:**
```bash
# Use rsync instead of cp
rsync -av --delete /etc/ "$backup_dir/$backup_date/"

# Exclude unnecessary files
rsync -av --exclude='*.cache' --exclude='*.tmp' /etc/ "$backup_dir/$backup_date/"
```

**Reduce storage:**
```bash
# Compress backups
tar -czf "$backup_dir/$backup_date.tar.gz" /etc/

# Use hard links for unchanged files
cp -al "$last_backup" "$new_backup"
```

## Monitoring and Alerting

### Backup Monitoring Script
```bash
#!/bin/bash
# monitor_backups.sh

backup_dir="/path/to/backup/directory"
max_age_hours=26  # Alert if no backup in 26 hours

latest_backup=$(ls -t "$backup_dir" | head -1)
latest_backup_time=$(stat -c %Y "$backup_dir/$latest_backup")
current_time=$(date +%s)
age_hours=$(( ($current_time - $latest_backup_time) / 3600 ))

if [ $age_hours -gt $max_age_hours ]; then
    echo "WARNING: Latest backup is $age_hours hours old" | mail -s "Backup Alert" admin@example.com
fi
```

## Related Scripts

- See `../networking/copy_to_remote_server.sh` for remote backup transfers
- See `../file-management/` for file operation utilities
- See `../system/maintenance_and_loggjng.sh` for backup logging

## Compliance and Regulations

Consider legal requirements for data retention:
- **GDPR**: EU data protection regulation
- **HIPAA**: Healthcare data in the US
- **SOX**: Financial data retention
- **PCI DSS**: Payment card industry standards

Ensure backup procedures comply with applicable regulations in your jurisdiction.
