Feature: syntax

  In order to be able to check an object's validity
  As a developer
  I want to specify what a valid object looks like

  Scenario: true is true
    Given a file named "true_is_true.rb" with:
      """
      require 'inspector'

      Inspector.valid("true value") do
        should be_true
      end

      violations = Inspector.validate(true, :as => "true value")
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
      require 'inspector'

      Inspector.valid("true value") do
        should be_true
      end

      violations = Inspector.validate(false, :as => "true value")
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

  Scenario: object attributes
    Given a file named "object.rb" with:
      """
      require 'inspector'

      User = Struct.new(:username, :email)

      Inspector.valid(User) do
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
      violations = Inspector.validate(user)

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

  Scenario: nested objects
    Given a file named "post_and_author.rb" with:
      """
      require 'inspector'

      Post   = Struct.new(:title, :body, :author)
      Author = Struct.new(:email, :first_name, :last_name)

      Inspector.valid(Post) do
        attribute(:title) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(3).characters
        end

        attribute(:body) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(3).characters
        end

        attribute(:author).should validate(:as => Author)
      end

      Inspector.valid(Author) do
        attribute(:email) do
          should_not be_empty
          should be_an_email
        end

        attribute(:first_name) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(1).character
          should have_at_most(32).characters
        end

        attribute(:last_name) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(1).character
          should have_at_most(32).characters
        end
      end

      author = Author.new("not an email", "John", "Smith")
      post   = Post.new(123, nil, author)

      violations = Inspector.validate(post)

      if violations.empty?
        puts "post #{post.inspect} is valid"
      else
        puts "invalid post #{post.inspect}:"
        puts violations.to_s.split("\n").map { |line| "  #{line}" }.join("\n")
      end
      """
    When I run `ruby post_and_author.rb`
    Then the output should contain:
      """
      invalid post #<struct Post title=123, body=nil, author=#<struct Author email="not an email", first_name="John", last_name="Smith">>:
        title:
          should.be_kind_of
        body:
          should_not.be_empty
          should.be_kind_of
          should.have_at_least
        author:
          email:
            should.be_an_email
      """

  Scenario: hash validation
    Given a file named "request.rb" with:
      """
      require 'inspector'

      Inspector.valid("request parameters") do
        property("title") do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(3).characters
        end

        property("body") do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(3).characters
        end
      end

      violations = Inspector.validate({
        "title" => 123,
        "body"  => nil
      }, :as => "request parameters")

      puts violations unless violations.empty?
      """
    When I run `ruby request.rb`
    Then the output should contain:
      """
      [title]:
        should.be_kind_of
      [body]:
        should_not.be_empty
        should.be_kind_of
        should.have_at_least
      """

    Scenario: array validation
      Given a file named "request.rb" with:
        """
        require 'inspector'

        Inspector.valid("emails") do
          each_item.should be_an_email
        end

        puts Inspector.validate(["not an email", "username@example.com"], :as => "emails")
        """
      When I run `ruby request.rb`
      Then the output should contain:
        """
        [0]:
          should.be_an_email
        """