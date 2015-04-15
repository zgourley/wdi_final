class User
  include Mongoid::Document

  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String
  
  field :github_handle, type: String
  field :address, type: String
  field :employer, type: String
  field :favorite_number, type: Integer

end
