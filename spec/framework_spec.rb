require './lib/instadroid-server/framework'

describe Framework do
  it "must store paths mapped to code-blocks" do
    f = Framework.new
    f.path_hashes.should be_kind_of(Hash)
    f.path_hashes.values.all? {|hash| hash.should be_kind_of(Hash) }
  end

  it "must store GET & POST paths separately" do 
    f = Framework.new
    f.path_hashes.should have_exactly(2).items
    f.path_hashes.keys.should include(:GET, :POST)
  end
end