class CustomerSerializer
  include JSONAPI::Serializer

  attributes :firstname, :lastname, :email, :address
  
end
