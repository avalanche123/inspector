Feature: error display

  It is important to be able to render validation failures with correct error messages

  Scenario: object attributes
    Given a file named "object.rb" with:
      """
      require 'frank'

      Profile     = Struct.new(:first_name, :last_name, :date_of_birth, :preferences)
      User        = Struct.new(:username, :email, :profile)

      Frank.valid(Profile) do
        attribute(:first_name) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(8).characters
          should have_at_most(32).characters
        end

        attribute(:last_name) do
          should_not be_empty
          should be_kind_of(String)
          should have_at_least(8).characters
          should have_at_most(32).characters
        end

        attribute(:date_of_birth) do
          should_not be_empty
          should be_kind_of(Date)
        end

        attribute(:preferences) do
          property("terms_and_conditions").should be_true
          property("show_email").should_not be_empty
        end
      end

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

        attribute(:profile) do
          should be_valid(Profile)
        end
      end

      errors = Frank.validate(User.new("", "bademail", Profile.new("", nil, false, {
        "terms_and_conditions" => false,
        "show_email" => nil
      })))

      errors.each do |violation|
        puts violation.path
        violation.constraints.each do |constraint|
          puts "  #{constraint}"
        end
      end

      errors[:profile][:preferences]["show_email"]

      errors.at(".profile.preferences[show_email]")

      errors.at(".profile.preferences[show_email]")
      """
    When I run `ruby object.rb`

