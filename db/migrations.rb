module DB
  def self.migrate
    salt = Helpers.new_salt
    User.create(
      :username => "timothyandrew", 
      :pass_hash => digest = Digest::MD5.hexdigest("mfalcon" + salt),
      :salt => salt
    )
  end
end