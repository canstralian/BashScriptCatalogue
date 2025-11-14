# File Management Scripts

This directory contains scripts for file operations, filtering, searching, and general file management tasks.

## Scripts

### 📋 copy_file_func.sh

**Description:** Copies a file from one location to another with validation checks.

**Usage:**
```bash
./copy_file_func.sh
```

**Function:**
```bash
copyFile <source_path> <destination_path>
```

**Parameters:**
- `$1`: Source file path
- `$2`: Destination file path

**Features:**
- Validates source file exists
- Checks if destination already exists (prevents overwriting)
- Provides success/error messages

**Example:**
```bash
copyFile "/path/to/source/file.txt" "/path/to/destination/file.txt"
```

**Exit Codes:**
- `0`: Success
- `1`: Source file doesn't exist or destination already exists

---

### 🔍 filter_files.sh

**Description:** Filters files and folders in a directory based on age and naming patterns.

**Usage:**
```bash
./filter_files.sh <directory> <days>
```

**Function:**
```bash
filterFiles <directory> <days>
```

**Parameters:**
- `$1`: Directory path to filter
- `$2`: Number of days for age filtering

**Features:**
- Finds files older than specified days
- Filters by specific naming pattern (9-digit number + `.sf_export_finished`)
- Creates a new directory in the specified location

**Example:**
```bash
filterFiles "/path/to/directory" 7
# Finds files older than 7 days matching pattern: 123456789.sf_export_finished
```

**Use Cases:**
- Cleaning up old export files
- Archiving aged data
- Automated file maintenance

---

### 🆕 find_newest_files.sh

**Description:** Finds the 100 newest files across the entire filesystem.

**Usage:**
```bash
./find_newest_files.sh
```

**Function:**
```bash
find_newest_files
```

**Parameters:**
- None (searches entire filesystem)

**Features:**
- Searches entire system starting from root (`/`)
- Sorts files by modification time (newest first)
- Returns top 100 newest files
- Uses efficient file timestamp comparison

**Example:**
```bash
./find_newest_files.sh
```

**Output Format:**
```
/path/to/newest/file1
/path/to/newest/file2
...
```

**Performance Notes:**
- May require elevated privileges to search all directories
- Can be slow on systems with many files
- Consider limiting search scope for faster results

**Modified Version for Specific Directory:**
```bash
# Edit the script to search a specific directory:
find /specific/directory -type f -printf '%T@ %p\n' | sort -nr | head -n 100 | cut -d' ' -f2-
```

## Common Use Cases

### Batch File Operations
Use these scripts for:
- Automated file copying with validation
- Age-based file cleanup
- Finding recently modified configuration files
- Identifying latest log files

### File Organization
Combine scripts for comprehensive file management:
```bash
# Find newest files, then copy them
./find_newest_files.sh | while read file; do
    ./copy_file_func.sh "$file" "/backup/$(basename "$file")"
done
```

### Scheduled Maintenance
Add to cron for automated file management:
```bash
# Daily cleanup of old export files
0 2 * * * /path/to/filter_files.sh /data/exports 30
```

## Best Practices

### Safety
- Always test with non-critical data first
- Use `-i` flag with `cp` for interactive mode
- Create backups before bulk operations
- Verify free disk space before copying large files

### Performance
- Limit filesystem searches to necessary directories
- Use appropriate filters to reduce result sets
- Consider running intensive searches during off-peak hours

### Automation
- Add logging to track operations
- Implement error handling
- Use file locks for concurrent operations
- Set up monitoring/alerting for critical operations

## Troubleshooting

**Permission Denied:**
```bash
# Run with sudo for system-wide searches
sudo ./find_newest_files.sh

# Or limit search to accessible directories
find ~/documents -type f -printf '%T@ %p\n' | sort -nr | head -n 100
```

**Disk Space Issues:**
```bash
# Check available space before copying
df -h
```

**Performance Issues:**
```bash
# Limit search depth
find /path -maxdepth 3 -type f -name "pattern*"

# Exclude certain directories
find /path -type f -not -path "*/node_modules/*"
```

## Related Scripts

- See `../backup/` for backup-specific operations
- See `../utilities/loops.sh` for advanced file iteration
- See `../networking/` for remote file operations

## Script Integration

These scripts can be sourced and used as functions in other scripts:
```bash
#!/bin/bash
source file-management/copy_file_func.sh

# Use the function
copyFile "$source" "$destination"
```
