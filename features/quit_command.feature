Feature: `quit` command

  In order to conclude a session
  As an end user of htty
  I want to issue a command to quit

  Scenario: quit htty using a command

    When I run "htty" interactively
    And I type "quit"
    Then the output should contain:
      """
      *** Happy Trails To You!
      """

  Scenario: quit htty using a command abbreviation

    When I run "htty" interactively
    And I type "qui"
    Then the output should contain:
      """
      *** Happy Trails To You!
      """

  Scenario: quit htty using a command alias

    When I run "htty" interactively
    And I type "exit"
    Then the output should contain:
      """
      *** Happy Trails To You!
      """

  Scenario: quit htty using an abbreviated command alias

    When I run "htty" interactively
    And I type "e"
    Then the output should contain:
      """
      *** Happy Trails To You!
      """
