# joomla-config

Bash script for managing [Joomla!](https://joomla.org) configuration values in `configuration.php` files.

## Installation

Just download the script to a directory in your `$PATH`. For example:

```sh
wget https://raw.githubusercontent.com/PopArtDesign/joomla-config/refs/heads/main/joomla-config \
    -O ~/.local/bin/joomla-config && chmod +x ~/.local/bin/joomla-config
```

## Usage

```
joomla-config [-f|--file <file>] [<name>] [<value>]
```

### Arguments

- `<name>`: The name of a configuration variable.
- `<value>`: The value of a configuration variable.

### Options

- `-f, --file <file>`: Specify configuration file (default: `./configuration.php`).
- `-h, --help`:  Show the help message and exit.

### Examples

```bash
# List all configuration values
joomla-config

# Get the database host value
joomla-config host

# Set the database host to localhost
joomla-config host localhost

# Use a specific configuration file
joomla-config -f /path/to/configuration.php
```

## License

Copyright (c) Voronkovich Oleg. Distributed under the [MIT](LICENSE).
