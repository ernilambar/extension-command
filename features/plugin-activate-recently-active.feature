Feature: Activate recently active WordPress plugins

  Scenario: Verify plugin installation, activation, deactivation and confirm activating recently active plugins list is correct
    Given a WP install

    When I run `wp plugin install site-secrets debug-bar p2-by-email --activate`
    Then STDOUT should contain:
      """
      Plugin 'site-secrets' activated.
      """
    And STDOUT should contain:
      """
      Plugin 'debug-bar' activated.
      """
    And STDOUT should contain:
      """
      Plugin 'p2-by-email' activated.
      """

    When I run `wp plugin deactivate site-secrets debug-bar`
    Then STDOUT should contain:
      """
      Plugin 'site-secrets' deactivated.
      Plugin 'debug-bar' deactivated.
      Success: Deactivated 2 of 2 plugins.
      """

    When I run `wp plugin activate --recently-active`
    Then STDOUT should contain:
      """
      Plugin 'site-secrets' activated.
      """
    And STDOUT should contain:
      """
      Plugin 'debug-bar' activated.
      """
    And STDOUT should contain:
      """
      Success: Activated 2 of 2 plugins.
      """

  Scenario: For a multisite, verify plugin activation from recently activate plugins list
    Given a WP multisite install

    When I run `wp plugin install site-secrets debug-bar p2-by-email --activate-network`
    Then STDOUT should contain:
      """
      Plugin 'site-secrets' network activated.
      """
    And STDOUT should contain:
      """
      Plugin 'debug-bar' network activated.
      """
    And STDOUT should contain:
      """
      Plugin 'p2-by-email' network activated.
      """

    When I run `wp plugin activate akismet --network`
    Then STDOUT should contain:
      """
      Plugin 'akismet' network activated.
      """

    When I run `wp plugin deactivate site-secrets debug-bar --network`
    Then STDOUT should be:
      """
      Plugin 'site-secrets' network deactivated.
      Plugin 'debug-bar' network deactivated.
      Success: Network deactivated 2 of 2 plugins.
      """

    When I run `wp plugin activate --recently-active --network`
    Then STDOUT should contain:
      """
      Plugin 'site-secrets' network activated.
      """
    And STDOUT should contain:
      """
      Plugin 'debug-bar' network activated.
      """
    And STDOUT should contain:
      """
      Success: Network activated 2 of 2 plugins.
      """
