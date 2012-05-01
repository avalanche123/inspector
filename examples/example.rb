class Address
  include Validation

  attribute :street, String
  assert :street, :not_blank

  attribute :zip_code, String
  assert :zip_code, :not_blank, :max_length => 5

  attribute :favorite_colors, Set[String]
  assert :favorite_colors, :all => [:not_blank, :max_length => 5]
end

class Author
  include Validation

  assert Unique[:email]

  attribute :first_name, String
  assert :first_name, :not_blank, :length => 4..5

  attribute :last_name, String
  assert :last_name, :not_blank

  attribute :address, Address
  assert :address, :valid
 
  attribute :email, String
  assert :email, :email
end