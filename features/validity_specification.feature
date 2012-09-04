Feature: validity specification

  In order to be able to check an object's validity
  As a developer
  I want to specify what a valid object looks like

  Scenario: violated validation context
    Given a file named "valid.rb" with:
      """
      require 'frank'

      Frank.valid("true value") do
        should be_true
      end

      p Frank.validate(false, :as => "true value")
      """
    When I run `ruby valid.rb`
    Then the output should contain:
      """
      false:
        should be true
      """