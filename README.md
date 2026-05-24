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
joomla-config [-f|--file <file>] [--raw] [--keys <keys>]
              [--db] [--cors] [--mail] [--caching] [--cookie]
              [--debug] [--logging] [--metadata] [--proxy]
              [--seo] [--server] [--session] [--site]

joomla-config [-f|--file <file>] [--raw] <name>

joomla-config [-f|--file <file>] [--raw] <name> <value>

joomla-config [-f|--file <file>] --list-keys

joomla-config --completion
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
- `--keys <keys>`: Show specified configuration keys (comma-separated). E.g.: `--keys db,user,password`
- `--list-keys`: List all available configuration keys.
- `-f, --file <file>`: Specify configuration file (default: `./configuration.php`).
- `--completion`: Print bash completion script.
- `-h, --help`:  Show the help message and exit.

### Examples

```bash
# List all configuration values
joomla-config

# List only database-related configuration values
joomla-config --db

# List only database and mail-related configuration values
joomla-config --db --mail

# List only specified keys
joomla-config --keys db,user,password

# Get the database host value
joomla-config host

# Set the database host to localhost
joomla-config host localhost

# Set a value without automatic quoting
joomla-config --raw host localhost

# Use a specific configuration file
joomla-config -f /path/to/configuration.php
```

## Bash Completion

`joomla-config` includes a bash completion script to enhance your command-line experience.

### Temporary Activation

To enable bash completion for your current session, you can source the completion script directly:

```sh
source <(joomla-config --completion)
```

### Permanent Installation

For permanent activation across all your shell sessions, you can save the completion script to a file and ensure it's sourced on startup.

**Method 1: System-wide installation (requires root privileges)**

Save the completion script to your system's bash completion directory:

```sh
sudo joomla-config --completion > /etc/bash_completion.d/joomla-config
```

Then, ensure your shell is configured to load scripts from this directory (often done automatically by `/etc/bash.bashrc` or similar).

**Method 2: User-specific installation**

Save the completion script to a file in your home directory, for example:

```sh
mkdir -p ~/.bash_completion.d
joomla-config --completion > ~/.bash_completion.d/joomla-config
```

Then, add the following line to your `~/.bashrc` or `~/.bash_profile` to source it on startup:

```sh
if [ -f ~/.bash_completion.d/joomla-config ]; then
    . ~/.bash_completion.d/joomla-config
fi
```

After either method, restart your terminal or run `source ~/.bashrc` (or `~/.bash_profile`) for the changes to take effect. This will provide command-line completion for options and configuration keys.

## License

Copyright (c) Voronkovich Oleg. Distributed under the [MIT](LICENSE).
