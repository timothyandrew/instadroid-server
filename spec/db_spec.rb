require 'data_mapper'
require './db/User'
require './db/Image'
require './db/helpers'
require './db/migrations'

describe DB do
  before(:all) do
    DataMapper.setup(:default, 'postgres://localhost/postgres')
    DataMapper.finalize
    DataMapper.auto_migrate!

    @salt = DB::Helpers.new_salt
    @user = User.create(
      :username => "timothyandrew", 
      :pass_hash => digest = Digest::MD5.hexdigest("mfalcon" + @salt),
      :salt => @salt
    )

    @image = Image.create(
      :path => "/Users/tim/dev/project/instadroid-server/images/cat.jpg",
      :user => @user
    )
  end

  it "is able to calculate the password hash given the password and the salt" do
    @password = "mfalcon"
    @user.pass_hash.should == Digest::MD5.hexdigest(@password + @user.salt)
  end

  describe "images" do
    it "get saved if an image exists at the specified path" do
      i = Image.create(
        :path => "/Users/tim/dev/project/instadroid-server/images/cat.jpg",
        :user => @user
      )      
      i.saved?.should be_true
    end

    it "do not get saved if an image DOES NOT exist at the specified path" do
      i = Image.create(
        :path => "/Users/tim/dev/project/instadroid-server/images/somefilethatdoesnotexist.jpg",
        :user => @user
      )      
      i.saved?.should_not be_true
    end
  end
end