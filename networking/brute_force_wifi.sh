import itertools

def brute_force_wifi_password(network_name: str):
    """
    Function to find out the password of a WiFi network by brute force.

    Parameters:
    - network_name: str
        The name (SSID) of the WiFi network for which the password needs to be found.

    Returns:
    - str:
        The password of the WiFi network, if found. Otherwise, returns None.

    Notes:
    - This function uses a brute force approach to try all possible combinations of passwords.
    - The function assumes that the password is a string of digits.
    """

    # Generate all possible combinations of passwords using digits from 0 to 9
    password_length = 8  # Assuming the password is 8 digits long
    possible_passwords = itertools.product('0123456789', repeat=password_length)

    # Iterate through each possible password and check if it matches the network name
    for password in possible_passwords:
        # Convert the password tuple to a string
        password_str = ''.join(password)

        # Check if the password matches the network name
        if password_str == network_name:
            return password_str

    # If no password is found, return None
    return None

# Example usage:
network_name = '0522195636-eLifeUltra750mbps'
password = brute_force_wifi_password(network_name)
if password:
    print(f"The password for the WiFi network '{network_name}' is: {password}")
else:
    print(f"No password found for the WiFi network '{network_name}'.")