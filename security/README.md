# Security Scripts

This directory contains scripts related to cryptography, key management, and security operations.

## Scripts

### 🔑 extract_prv_key.sh

**Description:** Extracts the private key from a Bitcoin address using base58 decoding and hexadecimal conversion.

**Usage:**
```bash
./extract_prv_key.sh
```

**Function:**
```bash
extract_private_key <bitcoin_address>
```

**Parameters:**
- `$1`: Bitcoin address (must match Bitcoin address format)

**Prerequisites:**
- `base58` utility must be installed
- `xxd` utility (usually pre-installed on Unix systems)

**Example:**
```bash
address="1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa"
echo "Private Key: $(extract_private_key "$address")"
```

**How It Works:**
1. Validates Bitcoin address format (must start with 1 or 3)
2. Removes prefix and checksum using base58 decoding
3. Converts base58 encoded payload to hexadecimal
4. Extracts the private key from the hex payload

**Warning:** 
- This script is for educational purposes
- Handle private keys with extreme care
- Never share private keys
- This implementation is simplified and may not work with all Bitcoin address types

---

### 🔐 remove_pgp.sh

**Description:** Removes the `.pgp.txt` extension from filenames.

**Usage:**
```bash
./remove_pgp.sh <path> <filename>
```

**Function:**
```bash
removeExtension <path> <filename>
```

**Parameters:**
- `$1`: Directory path where the file is located
- `$2`: Filename with `.pgp.txt` extension

**Returns:**
- Full path with new filename (extension removed)

**Example:**
```bash
removeExtension "/path/to/file" "example.pgp.txt"
# Output: /path/to/file/example
```

**Use Cases:**
- Batch processing of PGP-encrypted files after decryption
- Cleaning up file naming after encryption/decryption workflows
- Automation in secure file processing pipelines

## Security Best Practices

### General Guidelines

1. **Never store sensitive data in plaintext**
   - Use encryption for sensitive files
   - Secure private keys with proper permissions (chmod 600)

2. **Key Management**
   - Store keys in secure locations
   - Use hardware security modules (HSM) when possible
   - Rotate keys regularly

3. **Access Control**
   - Limit script execution to authorized users only
   - Use sudo only when necessary
   - Audit script execution logs

4. **Encryption Standards**
   - Use modern, well-tested cryptographic algorithms
   - Avoid deprecated methods (MD5, SHA1 for cryptographic purposes)
   - Keep cryptographic libraries updated

### File Permissions

Set appropriate permissions for security scripts:
```bash
chmod 700 extract_prv_key.sh  # Owner only
chmod 755 remove_pgp.sh       # Owner execute, others read
```

### Environment Security

- Run security scripts in isolated environments when possible
- Avoid running on shared systems without proper access controls
- Use virtual machines or containers for testing

## Troubleshooting

**base58 not found:**
```bash
# Install base58 utility
sudo apt-get install base58  # Debian/Ubuntu
brew install base58           # macOS
```

**Permission Denied:**
```bash
chmod +x *.sh
```

## Related Scripts

- See `../utilities/` for general-purpose processing scripts
- See `../file-management/` for file operation utilities

## Disclaimer

These scripts are provided for educational and legitimate use cases only. Users are responsible for ensuring compliance with applicable laws and regulations. The authors assume no liability for misuse of these tools.
