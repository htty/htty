Feature: Quit

  In order to exit HTTY
  As an end user
  I want to quit

  Scenario: quit
    When I run "htty" interactively
    When I type "quit"
    Then the output should contain:

    """
    *** Happy Trails To You!
    """

  Scenario: exit aliases quit
    When I run "htty" interactively
    When I type "exit"
    Then the output should contain:

    """
    *** Happy Trails To You!
    """
