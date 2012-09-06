Feature: validity specification

  In order to be able to check an object's validity
  As a developer
  I want to specify what a valid object looks like

  Scenario: false is not true
    Given a file named "false_is_not_true.rb" with:
      """
      require 'frank'

      Frank.valid("true value") do
        should be_true
      end

      p Frank.validate(false, :as => "true value")
      """
    When I run `ruby false_is_not_true.rb`
    Then the output should contain:
      """
      false:
        should be true
      """