Feature: `quit` command

  In order to conclude a session
  As an end user of htty
  I want to issue a command to quit

  Scenario: quit htty using a command

    Given an htty session
    When I type "quit"
    Then I should see the goodbye output

  Scenario: quit htty using a command abbreviation

    Given an htty session
    When I type "qui"
    Then I should see the goodbye output

  Scenario: quit htty using a command alias

    Given an htty session
    When I type "exit"
    Then I should see the goodbye output

  Scenario: quit htty using an abbreviated command alias

    Given an htty session
    When I type "e"
    Then I should see the goodbye output
