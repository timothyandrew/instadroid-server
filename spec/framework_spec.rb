require './lib/instadroid-server/framework'

describe Framework do
  it "maps paths to code-blocks directly" do
    f = Framework.new
    f.path_hashes.should be_kind_of(Hash)
    f.path_hashes.values.all? {|hash| hash.should be_kind_of(Hash) }
  end

  it "maps paths to code-blocks using regexes" do
    f = Framework.new

    block = Proc.new {
      "foo"
    }

    f.get /\/public\/.*/, &block
    opts = {"SERVER_SOFTWARE"=>"Apache/2.2.20 (Unix) DAV/2 Phusion_Passenger/3.0.9", 
                   "SERVER_PROTOCOL"=>"HTTP/1.1",                
                   "REQUEST_METHOD"=>"GET",
                   "PATH_INFO" => "/public/",
                   "QUERY_STRING" => "a=foo&b=bar"
                 }

    resp = f.call(opts)
    resp.should == "foo"

    opts["PATH_INFO"] = "/public/bar"
    resp = f.call(opts)
    resp.should == "foo"

    opts["PATH_INFO"] = "/public/bar/baz"
    resp = f.call(opts)
    resp.should == "foo"
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
                   "PATH_INFO" => path
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
                   "PATH_INFO" => path
                 })
    resp.should == "bar"
  end  

  it "should let you specify a default code block to be run for unknown paths" do 
    f = Framework.new
    path = '/index.html'

    block = Proc.new { 
      "bar"
    }

    f.get :default, &block
    resp = f.call({"SERVER_SOFTWARE"=>"Apache/2.2.20 (Unix) DAV/2 Phusion_Passenger/3.0.9", 
                   "SERVER_PROTOCOL"=>"HTTP/1.1",                
                   "REQUEST_METHOD"=>"GET",
                   "PATH_INFO" => path
                 })
    resp.should == "bar"
  end

  it "passes request environment variables to the code block" do
    f = Framework.new
    path = '/index.html'

    block = Proc.new { |env|
      env["QUERY_STRING"]
    }

    f.get path, &block
    resp = f.call({"SERVER_SOFTWARE"=>"Apache/2.2.20 (Unix) DAV/2 Phusion_Passenger/3.0.9", 
                   "SERVER_PROTOCOL"=>"HTTP/1.1",                
                   "REQUEST_METHOD"=>"GET",
                   "PATH_INFO" => path,
                   "QUERY_STRING" => "a=foo&b=bar"
                 })
    resp.should == "a=foo&b=bar"
  end
end