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

  Scenario: object attributes
    Given a file named "object.rb" with:
      """
      require 'frank'

      User = Struct.new(:username, :email)

      Frank.valid(User) do
        attribute(:username) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(8).characters
          should have_at_most(32).characters
          # attribute(:length) do
          #   should == 10
          # end
        end

        attribute(:email) do
          should_not be_empty
          should be_kind_of(String)
          should be_an_email
        end
      end

      p Frank.validate(User.new("", "bademail"))
      """
    When I run `ruby object.rb`
    Then the output should contain:
      """
      #<struct User username=nil, email="bademail">.username:
        should not be empty
        should have at least 32 characters
      #<struct User username=nil, email="bademail">.email:
        should be an email
      """