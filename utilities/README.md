# Utilities Scripts

This directory contains general-purpose utility scripts for text processing, pattern matching, string operations, and file iteration.

## Scripts

### 🔎 grep_display.sh

**Description:** Performs grep operations on files to find patterns between "Logical Displays" and "DIsplazModelDirector".

**Usage:**
```bash
./grep_display.sh <input_file> <output_file>
```

**Function:**
```bash
grepLogicalDisplaysToDIsplazModelDirector <input_file> <output_file>
```

**Parameters:**
- `$1`: Input file to search
- `$2`: Output file to store results

**Example:**
```bash
grepLogicalDisplaysToDIsplazModelDirector "input.txt" "output.txt"
```

---

### 🦅 Pegasus.sh

**Description:** Enhanced version of grep_display.sh with additional features like case sensitivity control and directory recursion.

**Usage:**
```bash
./Pegasus.sh <input> <output> [case_sensitive_flag]
```

**Function:**
```bash
grepLogicalDisplaysToDIsplazModelDirector <input> <output> [caseSensitive]
```

**Parameters:**
- `$1`: Input file or directory
- `$2`: Output file for results
- `$3`: Case sensitivity flag (optional, 0=sensitive, 1=insensitive, default=0)

**Features:**
- Recursive directory search
- Case-sensitive/insensitive matching
- Enhanced error handling
- Input validation

**Example:**
```bash
# Case-sensitive search
./Pegasus.sh "input.txt" "output.txt" 0

# Case-insensitive search in directory
./Pegasus.sh "/path/to/logs" "results.txt" 1
```

---

### 📧 if_string_contains.sh

**Description:** Checks if a string contains the word "gmail" using a brute-force character-by-character search.

**Usage:**
```bash
./if_string_contains.sh
```

**Function:**
```bash
brutte_forse_gmail <string>
```

**Parameters:**
- `$1`: String to check

**Returns:**
- "Found" if string contains "gmail"
- "Not Found" otherwise

**Examples:**
```bash
brutte_forse_gmail "example@gmail.com"  # Output: Found
brutte_forse_gmail "hello world"        # Output: Not Found
brutte_forse_gmail "gmail"              # Output: Found
```

**Customization:**
Modify the function to search for different patterns:
```bash
# Change the search term from "gmail" to another word
if [[ "${string:i:4}" == "test" ]]; then
```

---

### 🔍 pattern_grep.sh

**Description:** Advanced file search using find and multiple grep patterns.

**Usage:**
```bash
./pattern_grep.sh <directory> <pattern1> [pattern2] [pattern3] ...
```

**Function:**
```bash
search_files <directory> <patterns...>
```

**Parameters:**
- `$1`: Directory to search
- `$2+`: One or more search patterns

**Features:**
- Multiple pattern support
- Recursive file search
- Results saved to `search_results.txt`
- Pattern logging

**Example:**
```bash
./pattern_grep.sh "/path/to/directory" "*.txt" "*.csv"
./pattern_grep.sh "/var/log" "error" "warning" "critical"
```

---

### 🔄 loops.sh

**Description:** Loops through files matching multiple patterns and executes actions on each file.

**Usage:**
```bash
./loops.sh
```

**Function:**
```bash
loopThroughFiles "<patterns>" "<action>"
```

**Parameters:**
- `$1`: Space-separated file patterns
- `$2`: Action/command to execute on each file

**Features:**
- Multiple pattern support
- Handles filenames with spaces
- Executes custom commands on matched files

**Examples:**
```bash
# Print all .txt and .csv files
loopThroughFiles "*.txt *.csv" "echo File:"

# Delete all .jpg files
loopThroughFiles "*.jpg" "rm -f"

# Count lines in all .log files
loopThroughFiles "*.log" "wc -l"
```

**Safety Note:** Test with non-destructive commands first (like `echo`) before using destructive operations.

---

### 📚 generate_crossref.sh

**Description:** Generates a concordance (cross-reference) showing all word occurrences with line numbers.

**Usage:**
```bash
./generate_crossref.sh <target_file>
```

**Function:**
```bash
generateCrossReference <file>
```

**Parameters:**
- `$1`: Target file to analyze

**Features:**
- Creates word index with line numbers
- Removes punctuation from words
- Tracks multiple occurrences
- Case-sensitive word matching

**Example:**
```bash
./generate_crossref.sh "target.txt"
```

**Output Format:**
```
word1: 1 5 10
word2: 2 7
word3: 3 9 15 20
```

**Use Cases:**
- Document analysis
- Text indexing
- Finding word frequencies
- Creating back-of-book indexes

## Common Use Cases

### Text Processing Pipeline
Combine utilities for powerful text processing:
```bash
# Find files, search patterns, generate index
./pattern_grep.sh /docs "*.txt" > files.list
cat files.list | while read file; do
    ./generate_crossref.sh "$file" >> index.txt
done
```

### Automated File Processing
```bash
# Process all log files for specific patterns
./loops.sh "*.log" "./grep_display.sh"
```

### String Validation
```bash
# Check multiple email addresses
for email in $(cat emails.txt); do
    result=$(brutte_forse_gmail "$email")
    echo "$email: $result"
done
```

## Best Practices

### Performance
- Use appropriate patterns to limit search scope
- Consider file size when generating cross-references
- Test regex patterns before large-scale operations

### Safety
- Always test commands with echo first
- Use absolute paths for critical operations
- Back up files before bulk modifications

### Integration
These utilities can be sourced and used as libraries:
```bash
#!/bin/bash
source utilities/loops.sh
source utilities/if_string_contains.sh

# Use functions in your script
loopThroughFiles "*.txt" "process_file"
```

## Customization Examples

### Modify loops.sh for Custom Actions
```bash
# Add custom function
process_file() {
    local file="$1"
    echo "Processing: $file"
    # Add your processing logic
}

# Use with loops
loopThroughFiles "*.txt" "process_file"
```

### Extend pattern_grep.sh
```bash
# Add case-insensitive option
grep -iE "${patterns[*]}" > results.txt
```

### Enhance generate_crossref.sh
```bash
# Add case-insensitive matching
word=$(echo "$word" | tr '[:upper:]' '[:lower:]')
```

## Troubleshooting

**Pattern Not Matching:**
- Verify glob patterns are quoted: `"*.txt"`
- Check file permissions
- Ensure files exist in search path

**Memory Issues with Large Files:**
- Process files in chunks
- Use streaming tools like awk or sed
- Consider file size limits for cross-reference generation

**Character Encoding Problems:**
- Ensure files are in expected encoding (UTF-8)
- Use `iconv` to convert if needed

## Related Scripts

- See `../file-management/` for file operations
- See `../system/` for process management utilities

## Advanced Usage

### Combining Multiple Utilities
```bash
#!/bin/bash
# Search and index workflow

# 1. Find files with specific patterns
./pattern_grep.sh /data "*.log"

# 2. Filter files by age
find /data -name "*.log" -mtime -7 > recent_logs.txt

# 3. Generate cross-reference for recent logs
while read logfile; do
    ./generate_crossref.sh "$logfile" >> master_index.txt
done < recent_logs.txt

# 4. Search index for specific terms
./grep_display.sh master_index.txt filtered_results.txt
```

This utilities collection provides building blocks for creating sophisticated text processing and file management workflows.
