Feature: `http-get` command

  In order to use HTTP's GET method
  As an end user of htty
  I want to issue a corresponding htty command

  @request
  Scenario: issue a simple GET request using a command

    Given an htty session with htty.github.com
    When I type "http-get"
    And I type "quit"
    Then I should see the 200 OK output

  @request
  Scenario: issue a simple GET request using a command abbreviation

    Given an htty session with htty.github.com
    When I type "http-g"
    And I type "quit"
    Then I should see the 200 OK output

  @request
  Scenario: issue a simple GET request using a command alias

    Given an htty session with htty.github.com
    When I type "get"
    And I type "quit"
    Then I should see the 200 OK output

  @request
  Scenario: issue a simple GET request using an abbreviated command alias

    Given an htty session with htty.github.com
    When I type "g"
    And I type "quit"
    Then I should see the 200 OK output
