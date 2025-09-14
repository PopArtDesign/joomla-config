# shellcheck shell=sh

Describe 'joomla-production'

  PATH="${PWD}:${PATH}"

  It "shows help message with --help option"
    When run ./joomla-production --help
    The status should be success
    The output should include 'Check and fix Joomla production settings.'
    The output should include 'Usage: joomla-production'
  End

  It "shows help message with -h option"
    When run ./joomla-production -h
    The status should be success
    The output should include 'Check and fix Joomla production settings.'
    The output should include 'Usage: joomla-production'
  End

  It "shows error message if configuration file not exists"
    When run ./joomla-production -f /non/existent/file.php
    The status should not be success
    The stderr should include 'configuration file not found'
  End

  It "runs production checks successfully with valid configuration"
    # Create temporary directories for testing
    mkdir -p /tmp/joomla_test_tmp /tmp/joomla_test_logs

    # Create a test configuration file
    cat > /tmp/test_configuration.php <<'EOF'
<?php
class JConfig {
  public $offline = '0';
  public $sitename = 'Test Site';
  public $error_reporting = 'none';
  public $debug = '0';
  public $sef = '1';
  public $sef_rewrite = '1';
  public $tmp_path = '/tmp/joomla_test_tmp';
  public $log_path = '/tmp/joomla_test_logs';
}
EOF

    When run ./joomla-production -f /tmp/test_configuration.php
    The status should be success
    The output should include 'Checking Joomla! production settings'
    The output should include 'All production settings checks passed!'

    # Clean up
    rm -f /tmp/test_configuration.php
    rm -rf /tmp/joomla_test_tmp /tmp/joomla_test_logs
  End

  It "fixes issues with --fix option"
    # Create a test configuration file with issues
    cat > /tmp/test_configuration.php <<'EOF'
<?php
class JConfig {
  public $offline = '0';
  public $sitename = 'Test Site';
  public $error_reporting = 'maximum';
  public $debug = '1';
  public $sef = '0';
  public $sef_rewrite = '0';
  public $tmp_path = '/non/existent/path';
  public $log_path = '/non/existent/path';
}
EOF

    When run ./joomla-production -f /tmp/test_configuration.php --fix
    The status should be success
    The output should include 'Checking Joomla! production settings'
    The output should include 'Fixed 4 issue(s).'

    # Clean up
    rm -f /tmp/test_configuration.php
  End

End
