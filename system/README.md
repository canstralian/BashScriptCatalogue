# System and Process Management Scripts

This directory contains scripts for system administration, process management, automation, and maintenance tasks.

## Scripts

### 🖥️ pid_to_process.sh

**Description:** Converts Windows Process ID (PID) to process name using the tasklist command.

**Usage:**
```bash
./pid_to_process.sh
```

**Function:**
```bash
convertWindowsPidToProcessName <pid>
```

**Parameters:**
- `$1`: Windows Process ID (PID)

**Returns:**
- Process name associated with the PID
- Error message if PID not found

**Example:**
```bash
convertWindowsPidToProcessName 1234
# Output: chrome.exe (or appropriate process name)
```

**Prerequisites:**
- Windows environment (uses `tasklist` command)
- Appropriate permissions to query process list

**Use Cases:**
- Debugging Windows processes
- Process monitoring scripts
- Automated process management

**Note:** This script is designed for Windows environments. For Linux/Unix, use:
```bash
ps -p <pid> -o comm=
```

---

### 🔄 restart_every_6hr.sh

**Description:** Automatically restarts a script or application every 6 hours, with Java version detection for Project Zomboid game server.

**Usage:**
```bash
./restart_every_6hr.sh "<command>"
```

**Function:**
```bash
auto_restart_script <command>
```

**Parameters:**
- `$1`: Command to execute before each restart

**Features:**
- 6-hour interval loop
- 64-bit and 32-bit Java detection
- Library path configuration
- Pre-restart command execution

**Example:**
```bash
./restart_every_6hr.sh "echo 'Restarting server...'"
```

**Customization:**
```bash
# Change restart interval (e.g., 12 hours)
sleep 12h

# Add custom Java detection
if java -version 2>&1 | grep -q "64-Bit"; then
    # 64-bit Java logic
fi
```

**Use Cases:**
- Game server management
- Application uptime maintenance
- Memory leak mitigation
- Automated updates and restarts

---

### 📺 start_screens_run_commands.sh

**Description:** Starts multiple GNU Screen sessions, navigates to specific directories, and runs commands in each.

**Usage:**
```bash
./start_screens_run_commands.sh
```

**Function:**
```bash
start_screens_and_run_commands
```

**Features:**
- Creates 3 separate screen sessions
- Changes directory in each screen
- Executes commands in each session
- Runs in detached mode

**Default Configuration:**
```bash
Screen 1: cd /path/to/folder1 && command1
Screen 2: cd /path/to/folder2 && command2
Screen 3: cd /path/to/folder3 && command3
```

**Customization:**
Edit the script to add more screens or change commands:
```bash
# Add a fourth screen
screen -dmS screen4
screen -S screen4 -X stuff "cd /path/to/folder4$(printf \\r)"
screen -S screen4 -X stuff "command4$(printf \\r)"
```

**Prerequisites:**
- GNU Screen installed: `sudo apt-get install screen`

**Useful Screen Commands:**
```bash
# List all screens
screen -ls

# Attach to a screen
screen -r screen1

# Detach from screen: Ctrl+A, then D

# Kill a screen
screen -X -S screen1 quit
```

**Use Cases:**
- Running multiple services simultaneously
- Development environment setup
- Parallel task execution
- Long-running background processes

---

### 🔧 maintenance_and_loggjng.sh

**Description:** Performs maintenance tasks (backup, cleanup, update) with timestamp logging.

**Usage:**
```bash
./maintenance_and_loggjng.sh <action>
```

**Function:**
```bash
maintenance_and_logging <action>
```

**Parameters:**
- `$1`: Action to perform (`backup`, `cleanup`, `update`)

**Features:**
- Timestamp logging
- Multiple maintenance actions
- Automatic log file creation
- Action validation

**Available Actions:**

1. **backup** - Performs backup operations
```bash
./maintenance_and_loggjng.sh backup
```

2. **cleanup** - Performs system cleanup
```bash
./maintenance_and_loggjng.sh cleanup
```

3. **update** - Performs system updates
```bash
./maintenance_and_loggjng.sh update
```

**Log Format:**
```
[2024-01-15 10:30:45] Action: backup
[2024-01-15 11:00:12] Action: cleanup
[2024-01-15 14:20:33] Action: update
```

**Customization:**
Add your own maintenance actions:
```bash
case "$action" in
    "backup")
        # Your backup logic
        rsync -av /data /backup
        ;;
    "cleanup")
        # Your cleanup logic
        find /tmp -mtime +7 -delete
        ;;
    "custom")
        # Add custom action
        echo "Running custom maintenance..."
        ;;
esac
```

**Scheduling with Cron:**
```bash
# Daily backup at 2 AM
0 2 * * * /path/to/maintenance_and_loggjng.sh backup

# Weekly cleanup on Sunday at 3 AM
0 3 * * 0 /path/to/maintenance_and_loggjng.sh cleanup

# Monthly updates on 1st day at 4 AM
0 4 1 * * /path/to/maintenance_and_loggjng.sh update
```

## Common Use Cases

### Automated Service Management
```bash
# Combine restart script with maintenance
./maintenance_and_loggjng.sh backup
./restart_every_6hr.sh "systemctl restart myservice"
```

### Multi-Service Deployment
```bash
# Use screens to manage multiple services
# Edit start_screens_run_commands.sh:
screen -dmS web_server
screen -S web_server -X stuff "cd /var/www && npm start$(printf \\r)"

screen -dmS api_server
screen -S api_server -X stuff "cd /var/api && python app.py$(printf \\r)"

screen -dmS worker
screen -S worker -X stuff "cd /var/worker && ./process_jobs.sh$(printf \\r)"
```

### Process Monitoring
```bash
# Monitor specific processes (Windows)
while true; do
    pid=$(tasklist | grep "myapp.exe" | awk '{print $2}')
    ./pid_to_process.sh "$pid"
    sleep 60
done
```

## Best Practices

### Process Management
- Use PID files to track running processes
- Implement graceful shutdown procedures
- Add signal handlers for clean exits
- Monitor resource usage

### Logging
- Rotate log files to prevent disk space issues
- Use log levels (INFO, WARN, ERROR)
- Include timestamps for all events
- Centralize logs when possible

### Automation
- Test scripts in non-production first
- Implement error handling and notifications
- Use file locks to prevent concurrent execution
- Document all automated tasks

### Screen Sessions
- Use meaningful session names
- Document screen configurations
- Monitor resource usage in detached screens
- Clean up terminated screens regularly

## Troubleshooting

### Screen Issues

**Screen not found:**
```bash
# Install screen
sudo apt-get install screen  # Debian/Ubuntu
sudo yum install screen       # RedHat/CentOS
```

**Cannot attach to screen:**
```bash
# Kill zombie screen
screen -wipe

# Force detach and reattach
screen -D -r screen1
```

### Process Issues

**PID not found:**
```bash
# Verify PID exists
ps -p <pid>  # Linux/Unix
tasklist /FI "PID eq <pid>"  # Windows
```

**Restart loop fails:**
- Check Java installation path
- Verify permissions on directories
- Review system logs for errors

### Logging Issues

**Log file permissions:**
```bash
# Fix log file permissions
chmod 644 maintenance_log.txt
chown user:group maintenance_log.txt
```

**Disk space:**
```bash
# Check disk space
df -h

# Compress old logs
gzip maintenance_log.txt.old
```

## Integration Examples

### Complete Maintenance Workflow
```bash
#!/bin/bash
# maintenance_workflow.sh

# Run pre-maintenance checks
./maintenance_and_loggjng.sh backup

# Stop services
screen -X -S myapp quit

# Perform cleanup
./maintenance_and_loggjng.sh cleanup

# Restart services in screens
./start_screens_run_commands.sh

# Verify processes
sleep 5
screen -ls
```

### Monitoring Script
```bash
#!/bin/bash
# monitor.sh

while true; do
    # Check if screens are running
    if ! screen -ls | grep -q "myapp"; then
        echo "Service down, restarting..."
        ./start_screens_run_commands.sh
        ./maintenance_and_loggjng.sh "restart"
    fi
    sleep 300  # Check every 5 minutes
done
```

## Related Scripts

- See `../backup/` for backup-specific scripts
- See `../utilities/` for log processing utilities
- See `../file-management/` for file operations

## Security Considerations

- Run services with least privilege
- Validate all input parameters
- Secure log files from unauthorized access
- Use sudo only when necessary
- Audit script execution regularly
