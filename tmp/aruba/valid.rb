require 'frank'

Frank.valid("true value") do
  should be_true
end

p Frank.validate(false, :as => "true value")