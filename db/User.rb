class User
  include DataMapper::Resource

  property :id,        Serial
  property :username,  String
  property :pass_hash, String
  property :salt,      String
end