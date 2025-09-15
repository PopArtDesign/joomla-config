# joomla-config

[![CI](https://github.com/PopArtDesign/joomla-config/actions/workflows/tests.yaml/badge.svg)](https://github.com/PopArtDesign/joomla-config/actions/workflows/tests.yaml)

Bash script for managing [Joomla!](https://joomla.org) configuration values in `configuration.php` files.

## Installation

Just download the script to a directory in your `$PATH`. For example:

```sh
wget https://raw.githubusercontent.com/PopArtDesign/joomla-config/refs/heads/main/joomla-config \
    -O ~/.local/bin/joomla-config && chmod +x ~/.local/bin/joomla-config
```

## Usage

```
joomla-config [-f|--file <file>] [--raw] [--fields <fields>]
              [--db] [--cors] [--mail] [--caching] [--cookie]
              [--debug] [--logging] [--metadata] [--proxy]
              [--seo] [--server] [--session] [--site]

joomla-config [-f|--file <file>] [--raw] <name>

joomla-config [-f|--file <file>] [--raw] <name> <value>
```

### Arguments

- `<name>`: The name of a configuration variable.
- `<value>`: The value of a configuration variable.

### Options

- `--raw`: Use values without quoting/unquoting. When setting values, do not automatically quote the value.
- `--db`: Show database-related configuration values.
- `--cors`: Sho CORS-related configuration values.
- `--mail`: Show mail-related configuration values.
- `--caching`: Show caching-related configuration values.
- `--cookie`: Show cookie-related configuration values.
- `--debug`: Show debug-related configuration values.
- `--logging`: Show logging-related configuration values.
- `--metadata`: Show metadata-related configuration values.
- `--proxy`: Show proxy-related configuration values.
- `--seo`: Show SEO-related configuration values.
- `--server`: Show server-related configuration values.
- `--session`: Show session-related configuration values.
- `--site`: Show  site-related configuration values.
- `--fields <fields>`: Show specified configuration fields (comma-separated). E.g.: `--fields db,user,password`
- `-f, --file <file>`: Specify configuration file (default: `./configuration.php`).
- `-h, --help`:  Show the help message and exit.

### Examples

```bash
# List all configuration values
joomla-config

# List only database-related configuration values
joomla-config --db

# List only database and mail-related configuration values
joomla-config --db --mail

# List only specified fields
joomla-config --fields db,user,password

# Get the database host value
joomla-config host

# Set the database host to localhost
joomla-config host localhost

# Set a value without automatic quoting
joomla-config --raw host localhost

# Use a specific configuration file
joomla-config -f /path/to/configuration.php
```

## License

Copyright (c) Voronkovich Oleg. Distributed under the [MIT](LICENSE).
