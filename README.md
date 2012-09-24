# Inspector

a ruby validation library

## Background

We often need to validate data. And a lot of the time we're forced to put those validation rules on our so-called models. I think this is making too many assumptions about the styles of applications that we're writing and doesn't give us enough flexibility to implement something outside of this box.

Validating models is great, sure. Very often I find myself needing to validate hashes or arrays, before I even hydrate that data on my models. Other times, I don't have the luxury of using a traditional ORM - maybe I store my data in XML files or maybe I don't even store it anywhere at all.

Inspector is designed to avoid those assumptions and give the developer flexibility and power of object validation dressed in a nice DSL. The actual validations definition syntax takes inspiration from RSpec's powerful matchers. And with nested validations your validation rules are guaranteed to be ever so concise and readable.

Read through quick start to get basic idea of what I'm talking about.

## Quick start

```ruby
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
```

Above code will result in the following:

```shell
invalid post #<struct Post title=123, body=nil, author=#<struct Author email="not an email", first_name="John", last_name="Smith">>:
  title:
    should_not.be_empty
    should.be_kind_of
  body:
    should_not.be_empty
    should.be_kind_of
    should.have_at_least
  author:
    email:
      should.be_an_email
```

The above example is fairly simplistic, yet demonstrates several important features:

* Validation constraints can be negated (the use of should_not enforces this)
* It is possible to nest validations (`author` attribute in `Post` validation rules)
* Validations are not tied to error messages

## Usage

The quick start above highlighted basic usage scenario. However, this is definitely not everything Inspector can do.

### Validating hashes

```ruby
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
}, :as => "requests parameters")

puts violations unless violations.empty?
```

The code above will result in the following:

```shell
[title]:
  should_not.be_empty
  should.be_kind_of
[body]:
  should_not.be_empty
  should.be_kind_of
  should.have_at_least
```

### Validating arrays

```ruby
require 'inspector'

Inspector.valid("emails") do
  each_item.should be_an_email
end

puts Inspector.validate(["not an email", "username@example.com"], :as => "emails")
```

```shell
[0]:
  should.be_an_email
```

### DRYing validations

Sometimes we end up with almost exactly same validations on different attributes or properties. It is quite easy to remove the duplication by using `validate` constraint:


The validations above seem a little too verbose, but we can simplify them:

```ruby
require 'inspector'

Post   = Struct.new(:title, :body, :author)
Author = Struct.new(:email, :first_name, :last_name)

Inspector.valid("required string") do
  should_not be_empty
  should be_kind_of(String)
  should have_at_least(3).characters
end

Inspector.valid("required short string") do
  should_not be_empty
  should be_kind_of(String)
  should have_at_least(1).character
  should have_at_most(32).characters
end

Inspector.valid(Post) do
  attribute(:title).should  validate :as => "required string"
  attribute(:body).should   validate :as => "required string"
  attribute(:author).should validate :as => Author
end

Inspector.valid(Author) do
  attribute(:email) do
    should_not be_empty
    should be_an_email
  end

  attribute(:first_name).should validate :as => "required short string"
  attribute(:last_name).should  validate :as => "required short string"
end
```

### Built-in constraints

Inspector ships with some built-in constraints. Most of them are inspired by RSpec's matchers.

#### `be_false`

validate falsiness of a value.

```ruby
attribute(:attribute) do
  should be_false
end
```

#### `be_true`

validate truthyness of a value.

```ruby
attribute(:attribute) do
  should be_true
end
```

#### `validate`

validate an object as a valid type (defaults to its class):

```ruby
attribute(:attribute) do
  should validate
end
```

```ruby
attribute(:attribute) do
  should validate(:as => 'validation metadata')
end
```

#### `be_email`/`be_an_email`

validate value as email.

```ruby
attribute(:attribute) do
  should be_email
end
```

```ruby
attribute(:attribute) do
  should be_an_email
end
```

#### `have/have_exactly`

validate collection length.

```ruby
attribute(:attribute) do
  should have(5).characters
end
```

```ruby
attribute(:attribute) do
  should have_exactly(5).characters
end
```

#### `have_at_least`

validate collection minimum length.

```ruby
attribute(:attribute) do
  should have_at_least(5).characters
end
```

#### `have_at_most`

validate collection maximum length.

```ruby
attribute(:attribute) do
  should have_at_most(5).characters
end
```

#### `be_*`

validate using predicate method.

```ruby
attribute(:attribute) do
  should be_valid # passes of attribute.valid? is true
end
```

### Defining simple validations (TODO)

```ruby
Inspector.define_constraint(:have_properties) do |*properties|
  valid? do |object|
    properties.all? { |property| object.has_key?(property) }
  end
end
```

### Defining custom validations (TODO)

```ruby

class HavePropertiesValidator
  def validate(value, constraint, violations_list)
    valid = constraint.properties.all? { |property| object.has_key?(property) }

    if valid ^ constraint.positive?
      violations_list << Inspector::Constraint::Violation.new(constraint)
    end
  end
end

class HavePropertiesConstraint
  include Inspector::Constraint

  def validator
    :have_properties
  end
end

Inspector.validators[:have_properties] = HavePropertiesValidator.new

Inspector.define_constraint(:have_properties, HavePropertiesConstraint)
```
