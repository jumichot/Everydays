Feature: greeter says hello

  In order to start learning Rspec and Cucumber
  As a reader of The Rspec Book
  I want a greeter to say Hello

  Scenario: greeter says hello
    Given a greeter
    When I send it the greet message
    Then I should see "Hello Cucumber!"
