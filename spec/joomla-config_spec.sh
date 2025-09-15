# shellcheck shell=sh

Describe 'joomla-config'

  It "lists all configuration values if no arguments provided"
    When run ./joomla-config -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include 'offline                   0'
    The output should include 'sitename                  Test Site'
    The output should include 'host                      localhost'
    The output should include 'user                      root'
    The output should include 'db                        test_joomla'
    The lines of output should equal 62
  End

  It "lists all configuration values with --raw option"
    When run ./joomla-config --raw -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "sitename                  'Test Site'"
    The output should include "host                      'localhost'"
    The output should include "user                      'root'"
    The output should include "db                        'test_joomla'"
    The lines of output should equal 62
  End

  It "lists only specified fields with --fields option"
    When run ./joomla-config --fields db,user,password -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "db         test_joomla"
    The output should include "user       root"
    The output should include "password"
    The lines of output should equal 3
  End

  It "lists only database-related configuration values with --db option"
    When run ./joomla-config --db -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "dbtype     mysqli"
    The output should include "host       localhost"
    The output should include "user       root"
    The output should include "password"
    The output should include "db         test_joomla"
    The output should include "dbprefix   jos_"
    The lines of output should equal 6
  End

  It "lists only mail-related configuration values with --mail option"
    When run ./joomla-config --mail -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "mailonline   1"
    The output should include "mailer       mail"
    The output should include "mailfrom     test@example.com"
    The output should include "fromname     Test Site"
    The output should include "sendmail     /usr/sbin/sendmail"
    The lines of output should equal 11
  End

  It "lists only debug-related configuration values with --debug option"
    When run ./joomla-config --debug -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "debug             0"
    The output should include "debug_lang        0"
    The output should include "error_reporting   default"
    The lines of output should equal 3
  End

  It "lists only caching-related configuration values with --caching option"
    When run ./joomla-config --caching -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "caching                0"
    The output should include "cache_handler          file"
    The output should include "cachetime              15"
    The output should include "cache_platformprefix   0"
    The lines of output should equal 4
  End

  It "lists only seo-related configuration values with --seo option"
    When run ./joomla-config --seo -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "sef            1"
    The output should include "sef_rewrite    0"
    The output should include "sef_suffix     0"
    The output should include "unicodeslugs   0"
    The lines of output should equal 4
  End

  It "lists only server-related configuration values with --server option"
    When run ./joomla-config --server -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "gzip        0"
    The output should include "offset      UTC"
    The output should include "secret      secret123"
    The output should include "tmp_path    /tmp"
    The lines of output should equal 5
  End

  It "lists only site-related configuration values with --site option"
    When run ./joomla-config --site -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "sitename                  Test Site"
    The output should include "editor                    tinymce"
    The output should include "access                    1"
    The output should include "offline                   0"
    The lines of output should equal 12
  End

  It "lists only session-related configuration values with --session option"
    When run ./joomla-config --session -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "session_handler   database"
    The output should include "lifetime          15"
    The output should include "shared_session    0"
    The lines of output should equal 3
  End

  It "lists only metadata-related configuration values with --metadata option"
    When run ./joomla-config --metadata -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "MetaDesc"
    The output should include "MetaAuthor    1"
    The output should include "MetaVersion   0"
    The lines of output should equal 4
  End

  It "lists only logging-related configuration values with --logging option"
    When run ./joomla-config --logging -f ./spec/fixtures/configuration.php
    The status should be success
    The output should include "log_path   /var/log/joomla"
    The lines of output should equal 1
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

  Describe "getting a single configuration value with --raw option"
    Parameters
      'offline'  "'0'"
      'sitename' "'Test Site'"
      'host'     "'localhost'"
      'user'     "'root'"
      'db'       "'test_joomla'"
    End

    It "gets the '${1}' configuration value with --raw"
      When run ./joomla-config --raw -f ./spec/fixtures/configuration.php "${1}"
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
      The value "${host}" should equal "'newhost'"
    End

    It "sets a configuration value with --raw option"
      When run ./joomla-config --raw -f /tmp/joomla-config_configuration.php debug true
      The status should be success
      The output should be blank

      debug="$(./joomla-config --raw -f /tmp/joomla-config_configuration.php debug)"
      The value "${debug}" should equal 'true'
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
    The status should be failure
    The stderr should include 'configuration file not found'
  End

  It "shows error message if trying to get not existing config value"
    When run ./joomla-config -f ./spec/fixtures/configuration.php nonexistent
    The status should be failure
    The output should be blank
    The stderr should include "joomla-config: 'nonexistent' not found"
  End

  It "shows error message if trying to set not existing config value"
    When run ./joomla-config -f ./spec/fixtures/configuration.php nonexistent newvalue
    The status should be failure
    The output should be blank
    The stderr should include "joomla-config: 'nonexistent' not found"
  End

  It "shows error message with too many arguments"
    When run ./joomla-config -f ./spec/fixtures/configuration.php arg1 arg2 arg3
    The status should not be success
    The stderr should include 'too many arguments'
  End
End
