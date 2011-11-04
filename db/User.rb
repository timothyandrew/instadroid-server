class User
  include DataMapper::Resource

  property :id,        Serial
  property :username,  String, :required => true
  property :pass_hash, String
  property :salt,      String

  has n, :images
end