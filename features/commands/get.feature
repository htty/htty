Feature: Get

  In order to interact with a url
  As an end user
  I want to get it

  Scenario:
    When I run "htty" interactively
    And I type "address htty.github.com"
    And I type "get"
    And I type "quit"
    Then the output should match:

    """
    200.* OK -- 9 headers -- 17478-character body
    """
