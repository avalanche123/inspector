Feature: syntax

  In order to be able to check an object's validity
  As a developer
  I want to specify what a valid object looks like

  Scenario: true is true
    Given a file named "true_is_true.rb" with:
      """
      require 'frank'

      Frank.valid("true value") do
        should be_true
      end

      violations = Frank.validate(true, :as => "true value")
      if violations.empty?
        puts "true is true"
        exit 0
      else
        puts "true is not true"
        exit 1
      end
      """
    When I run `ruby true_is_true.rb`
    Then it should pass with:
      """
      true is true
      """

  Scenario: false is not true
    Given a file named "false_is_not_true.rb" with:
      """
      require 'frank'

      Frank.valid("true value") do
        should be_true
      end

      violations = Frank.validate(false, :as => "true value")
      if violations.empty?
        puts "true is true"
        exit 0
      else
        puts "false is not true"
        exit 1
      end
      """
    When I run `ruby false_is_not_true.rb`
    Then it should fail with:
      """
      false is not true
      """

  @wip
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
        end

        attribute(:email) do
          should_not be_empty
          should be_kind_of(String)
          should be_an_email
        end
      end

      user       = User.new("", "bademail")
      violations = Frank.validate(user)

      if violations.empty?
        puts "user #{user.inspect} is valid"
      else
        puts "invalid user #{user.inspect}:"
        puts violations.to_s.split("\n").map { |line| "  #{line}" }.join("\n")
      end
      """
    When I run `ruby object.rb`
    Then the output should contain:
      """
      invalid user #<struct User username="", email="bademail">:
        username:
          should_not.be_empty
          should.have_at_least
        email:
          should.be_an_email
      """