# Frank

a ruby validation library

## Installing

```shell
gem install frank
```

## Usage

```ruby
class Address
  assert :not_blank
  attribute :street, String

  assert :not_blank
  assert :max_length, 5
  attribute :zip_code, String

  assert :all, [
    assert :not_blank
    assert :min_length, 5
  ]
  attribute :favorite_colors, Set[String]
end

class Author
  assert :not_blank
  assert :min_length, 4
  attribute :first_name, String

  assert :not_blank
  attribute :last_name, String

  assert :valid
  attribute :address, Address
end
```
