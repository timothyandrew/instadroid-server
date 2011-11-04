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

  it "must store GET paths; each mapped to a code block" do
    f = Framework.new

    block = Proc.new { 
      #Some code here 
    }

    f.get '/', &block
    f.path_hashes[:GET]['/'].should equal(block)
  end

  it "must store POST paths; each mapped to a code block" do
    f = Framework.new

    block = Proc.new { 
      #Some code here 
    }

    f.post '/', &block
    f.path_hashes[:POST]['/'].should equal(block)
  end

  it "must execute the correct block when recieving a GET request" do
    f = Framework.new
    path = '/index.html'

    block = Proc.new { 
      "foo"
    }

    f.get '/index.html', &block
    resp = f.call({"SERVER_SOFTWARE"=>"Apache/2.2.20 (Unix) DAV/2 Phusion_Passenger/3.0.9", 
                   "SERVER_PROTOCOL"=>"HTTP/1.1",                
                   "REQUEST_METHOD"=>"GET",
                   "REQUEST_URI" => path
                 })
    resp.should == "foo"
  end

  it "must execute the correct block when recieving a POST request" do
    f = Framework.new
    path = '/index.html'

    block = Proc.new { 
      "bar"
    }

    f.post '/index.html', &block
    resp = f.call({"SERVER_SOFTWARE"=>"Apache/2.2.20 (Unix) DAV/2 Phusion_Passenger/3.0.9", 
                   "SERVER_PROTOCOL"=>"HTTP/1.1",                
                   "REQUEST_METHOD"=>"POST",
                   "REQUEST_URI" => path
                 })
    resp.should == "bar"
  end  

  it "should ignore unknown paths" do 
    f = Framework.new
    path = '/index.html'

    expect { f.call({"SERVER_SOFTWARE"=>"Apache/2.2.20 (Unix) DAV/2 Phusion_Passenger/3.0.9", 
                   "SERVER_PROTOCOL"=>"HTTP/1.1",                
                   "REQUEST_METHOD"=>"POST",
                   "REQUEST_URI" => path
                 })
           }.to_not raise_error(NoMethodError)
  end
end