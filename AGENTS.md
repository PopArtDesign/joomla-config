# AGENTS.md for joomla-config

This file provides context and instructions for AI coding agents working on the joomla-config project.

## Project Overview

This project provides bash scripts for managing Joomla! configuration values in `configuration.php` files. It consists of two main scripts:

1. `joomla-config` - Manage individual configuration values
2. `joomla-production` - Check and fix production settings

## Setup Commands

### Install dependencies
```bash
# Install ShellSpec for testing
curl -fsSL https://git.io/shellspec | sh -s 0.28.1 --yes
```

### Run tests
```bash
shellspec
```

## Code Style Guidelines

### Bash Scripting
- Use `#!/usr/bin/env bash` shebang
- Enable strict mode with `set -euo pipefail`
- Use `declare` for variable declarations
- Follow snake_case naming for functions and variables
- Use 4 spaces for indentation (no tabs)

### Error Handling
- Use the provided `fail()` and `error()` functions for error reporting
- Always check return codes for critical operations
- Provide meaningful error messages

## Testing Instructions

### Run all tests
```bash
shellspec
```

### Test structure
- Tests are written using ShellSpec framework
- Test files are in the `spec/` directory
- Each script has its corresponding spec file
- Tests use fixture files in `spec/fixtures/`

## Project-specific Instructions

### Adding new configuration checks
When adding new checks to `joomla-production`:
1. Add the check in the `check_production_settings()` function
2. Follow the existing pattern with `setting_get`, `setting_check`, and `setting_set`
3. Include both detection and fix logic
4. Add corresponding tests in `spec/joomla-production_spec.sh`

### Modifying configuration parsing
When modifying the configuration parsing in `joomla-config`:
1. Update the `config_load()` function
2. Ensure backward compatibility with existing Joomla config formats
3. Update tests in `spec/joomla-config_spec.sh`
4. Verify the sed expressions in `config_set()` still work correctly

## File Locations
- Main scripts: `joomla-config`, `joomla-production`
- Tests: `spec/*.sh`
- Fixtures: `spec/fixtures/configuration.php`
- CI: `.github/workflows/tests.yaml`

## Common Tasks

### Adding a new command-line option
1. Add the option parsing in the `main()` function
2. Add help text in the `help()` function
3. Implement the functionality
4. Add tests for the new option

### Modifying configuration value handling
1. Update the `config_get()` and `config_set()` functions
2. Modify the quoting/unquoting logic if needed
3. Update the sed expressions in `config_set()`
4. Add tests for edge cases