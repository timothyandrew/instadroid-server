module DB
  def self.migrate
    salt = Helpers.new_salt
    user = User.create(
      :username => "timothyandrew", 
      :pass_hash => digest = Digest::MD5.hexdigest("mfalcon" + salt),
      :salt => salt
    )

    image = Image.create(
      :path => "/static/images/cat.jpg",
      :user => user
    )
  end
end