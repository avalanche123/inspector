# class constraints
# attribute constraints
# property constraints

Inspector.valid(Address) do
  attribute(:street) do
    should_not be_empty
  end

  attribute(:zip_code) do
    should_not be_empty
    should have_at_most(5).characters
  end
end

# {
#   "[name]" => ["not.be_empty", "be_kind_of", "have_at_least", "have_at_most"]
# }
# 
Inspector.valid("request parameters") do
  should have_properties("name", "address")

  property("name") do
    should_not be_empty
    should be_kind_of(String)
    should have_at_least(3).characters
    should have_at_most(255).characters
    should have_only_letters_and_numbers
  end

  property("address") do
    should have_properties("recipient", "street", "street2", "city", "state", "zip")

    property("recipient") do
      should_not be_empty
      # should be_kind_of(String)
      should have_at_least(3).characters
      should have_at_most(255).characters
      should have_only_letters
    end

    property("street") do
      should_not be_empty
      # should be_kind_of(String)
      should have_at_least(3).characters
      should have_at_most(255).characters
      should have_only_letters_and_numbers
    end

    property("street2") do
      # should be_kind_of(String)
      should have_at_least(3).characters
      should have_at_most(255).characters
      should have_only_letters_and_numbers
    end

    property("city") do
      should_not be_empty
      # should be_kind_of(String)
      should have_at_least(3).characters
      should have_at_most(255).characters
      should have_only_letters_and_numbers
    end

    property("state") do
      should_not be_empty
      # should be_kind_of(String)
      should have_at_least(3).characters
      should have_at_most(255).characters
      should have_only_letters
    end

    property("zip") do
      should_not be_empty
      # should be_kind_of(String)
      should have_at_most(5).characters
    end
  end
end

result = Inspector.validate({:some_key => 'some value'}, :as => "request parameters")
result.valid?
result.errors
# errors = Inspector.validator_for("request parameters").validate({:some_key => 'some value'})

Inspector.validator.describe(Author) do
  should have_unique(:email)

  its.attribute(:first_name) do
    should_not be_empty
    should be_kind_of(String)

    should have_at_least(4).characters
    should have_at_most(5).characters
    # or
    # its.attribute(:length) do
    #   should be >= 4
    #   should be <= 5
    # end
  end

  its.attribute(:last_name) do
    should_not be_empty
    should be_kind_of(String)
  end

  its.attribute(:address).should be_valid(Address)

  its.attribute(:email).should be_an_email
end

errors = Inspector.validator.validate(Author.new)

errors.each do |property, violations|
  property.name
  property.path
end

{
  :violations => []
  :children => {
    :email => {
      :violations => ['is_unique'],
      :children => {
        :length => {
          :violations
        }
      }
    }
  }
}