# shellcheck shell=sh

Describe 'joomla-config'

  It "lists all configuration values if no arguments provided"
    When run ./joomla-config -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include 'offline: 0'
    The output should include 'sitename: Test Site'
    The output should include 'host: localhost'
    The output should include 'user: root'
    The output should include 'db: test_joomla'
    The lines of output should equal 62
  End

  Describe "getting a single configuration value"
    Parameters
      'offline'  '0'
      'sitename' 'Test Site'
      'host'     'localhost'
      'user'     'root'
      'db'       'test_joomla'
    End

    It "gets the '${1}' configuration value"
      When run ./joomla-config -f ./spec/fixtures/configuration.php "${1}"
      The status should be success
      The output should equal "${2}"
    End
  End

  Describe "setting a configuration value"
    prepare_config() {
      cp ./spec/fixtures/configuration.php /tmp/joomla-config_configuration.php
    }

    clean_config() {
      rm -f /tmp/joomla-config_configuration.php
    }

    BeforeEach 'prepare_config'
    AfterEach 'clean_config'

    It "sets a configuration value"
      When run ./joomla-config -f /tmp/joomla-config_configuration.php host newhost
      The status should be success
      The output should be blank

      host="$(./joomla-config -f /tmp/joomla-config_configuration.php host)"
      The value "${host}" should equal 'newhost'
    End
  End

  It "uses configuration.php from current directory by default"
    original_dir="${PWD}"

    cd ./spec/fixtures
    When run "${original_dir}/joomla-config" sitename
    cd "${original_dir}"

    The status should be success
    The output should equal "Test Site"
  End

  It "shows help message with --help option"
    When run ./joomla-config --help
    The status should be success
    The output should include 'Manage Joomla! configuration values.'
    The output should include 'Usage: joomla-config'
  End

  It "shows help message with -h option"
    When run ./joomla-config -h
    The status should be success
    The output should include 'Manage Joomla! configuration values.'
    The output should include 'Usage: joomla-config'
  End

  It "shows error message if configuration file not exists"
    When run ./joomla-config -f /non/existent/file.php
    The status should not be success
    The stderr should include 'configuration file not found'
  End

  It "returns empty output if configuration value not exists"
    When run ./joomla-config -f ./spec/fixtures/configuration.php nonexistent
    The status should be success
    The output should be blank
  End

  It "shows error message with too many arguments"
    When run ./joomla-config -f ./spec/fixtures/configuration.php arg1 arg2 arg3
    The status should not be success
    The stderr should include 'too many arguments'
  End
End
