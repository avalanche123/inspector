# Frank

a ruby validation library

## Disclaimer

This is a work in progress. Documented features are not yet implemented, this documentation is to describe what will be implemented.

## Installing

```shell
gem install frank
```

## Quick start

Let's say we have the following classes:

```ruby
Address = Struct.new(:recipient, :street, :street2, :city, :state, :zip)
Author  = Struct.new(:email, :first_name, :last_name, :address)
```

To be able to validate them, we need to describe validation rules for those classes:

```ruby
Frank.valid(Address) do
  attribute(:recipient) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_least(3).characters
    should have_at_most(255).characters
    should have_only_letters
  end

  attribute(:street) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_least(3).characters
    should have_at_most(255).characters
    should have_only_letters_and_numbers # custom validation constraint
  end

  attribute(:street2) do # optional
    should be_kind_of(String)
    should have_at_least(3).characters
    should have_at_most(255).characters
    should have_only_letters_and_numbers
  end

  attribute(:city) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_least(3).characters
    should have_at_most(255).characters
    should have_only_letters # custom validation constraint
  end

  attribute(:state) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_exactly(2).characters
    should have_only_uppercase_letters # custom validation constraint
  end

  attribute(:zip) do
    should_not be_empty
    should be_kind_of(String)
    should have_exactly_most(5).characters
    should have_only_numbers # custom validation constraint
  end
end

Frank.valid(Author) do
  should have_unique(:email) # custom validation constraint
  attribute(:email).should_not be_empty
  attribute(:email).should be_an_email # custom validation constraint
  # or
  attribute(:email) do
    should_not be_empty
    should be_unique # custom validation constraint
    should be_an_email # custom validation constraint
  end

  attribute(:first_name) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_least(1).character
    should have_at_most(32).characters
    # or
    # its.attribute(:length) do
    #   should be >= 4
    #   should be <= 5
    # end
    # has different validation semantics
  end

  attribute(:last_name) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_least(1).character
    should have_at_most(32).characters
  end

  attribute(:address).should be_valid
  # or
  attribute(:address).should be_valid(Address)
end
```

Now we can validate any instance of address or author:

```ruby
address = Address.new("John Smith", "123 Sesame Street", nil, "Neverland", "NY", "94608")
author  = Author.new("username@example.com", "John", "Smith", address)

validation_result = Frank.validate(author)
validation_result.valid?.should == true
```

The validations above seem a little too verbose, but we can simplify them:

```ruby
Frank.valid("medium string entry") do
  should be_kind_of(String)
  should have_at_least(3).characters
  should have_at_most(255).characters
end

Frank.valid("required string entry") do
  should_not be_empty
  should be_valid("string entry")
end

Frank.valid(Address) do
  attribute(:recipient) do
    should be_valid("required string entry")
    should have_only_letters
  end

  attribute(:street) do
    should be_valid("required string entry")
    should have_only_letters_and_numbers # custom validation constraint
  end

  attribute(:street2) do # street2 is optional
    should be_valid("medium string entry")
    should have_only_letters_and_numbers
  end

  attribute(:city) do
    should be_valid("required string entry")
    should have_only_letters # custom validation constraint
  end

  attribute(:state) do
    should_not be_empty
    should be_kind_of(String)
    should have_at_exactly(2).characters
    should have_only_uppercase_letters # custom validation constraint
  end

  attribute(:zip) do
    should_not be_empty
    should be_kind_of(String)
    should have_exactly_most(5).characters
    should have_only_numbers # custom validation constraint
  end
end

Frank.valid("name") do
  should_not be_empty
  should be_kind_of(String)
  should have_at_least(1).character
  should have_at_most(32).characters
end

Frank.valid(Author) do
  should have_unique(:email) # custom validation constraint
  attribute(:email).should_not be_empty
  attribute(:email).should be_an_email # custom validation constraint
  # or
  attribute(:email) do
    should_not be_empty
    should be_unique # custom validation constraint
    should be_an_email # custom validation constraint
  end

  attribute(:first_name).should be_valid("name")

  attribute(:last_name).should be_valid("name")

  attribute(:address).should be_valid
end
```

The above is nice when you have objects that you want to validate. Sometimes, however, all we have are Array and Hash structures. Frank supports those too:

```ruby
Frank.valid("required string") do
  should_not be_empty
  should be_kind_of(String)
end

Frank.valid("create author request parameters") do
  should have_properties("name", "address")

  property("name") do
    should be_valid("required string entry")
    should have_only_letters_and_numbers
  end

  property("address") do
    should have_properties("recipient", "street", "street2", "city", "state", "zip")

    property("recipient") do
      should be_valid("required string entry")
      should have_only_letters
    end

    property("street") do
      should be_valid("required string entry")
      should have_only_letters_and_numbers
    end

    property("street2") do
      should be_valid("medium string entry")
      should have_only_letters_and_numbers
    end

    property("city") do
      should be_valid("required string entry")
      should have_only_letters_and_numbers
    end

    property("state") do
      should be_valid("required string")
      should have_at_exactly(2).characters
      should have_only_uppercase_letters # custom validation constraint
    end

    property("zip") do
      should be_valid("required string")
      should have_exactly_most(5).characters
      should have_at_most(5).characters
    end
  end
end

params = {
  "name" => "John Smith",
  "address" => {
    "recipient" => "John Smith",
    "street" => "123 Sesame Street",
    "street2" => nil,
    "city" => "Neverland",
    "state" => "NY",
    "zip" => "94608"
  }
}

validation_result = Frank.validate(params, :as => "create author request parameters")

validation_result.valid?.should == true
```

And arrays:

```ruby
Frank.valid("email addresses") do
  should have_at_least(3).emails

  children do
    should_not be_empty
    should be_an_email
  end
end
```

## Built-in constraints

Frank ships with some built-in constraints. Most of them are inspired by RSpec's matchers.

* be_false     - validate falsiness of a value.
* be_true      - validate truthyness of a value.
* be_valid(type) - validate an object as a valid type (defaults to its class).

