Feature: Quit

  In order to exit HTTY
  As an end user
  I want to quit

  Scenario:
    When I run "htty" interactively
    And I type "quit"
    Then the output should contain:

    """
    *** Happy Trails To You!
    """
