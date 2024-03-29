class Framework 
  attr_reader :path_hashes

  def initialize
    @path_hashes = {:GET => {}, :POST => {}}
  end

  def get(path, &block)
    @path_hashes[:GET][path] = block
  end

  def post(path, &block)
    @path_hashes[:POST][path] = block
  end

  def call(env)
    path = env["PATH_INFO"]
    method = env["REQUEST_METHOD"].intern

    begin
      #Direct mapping exists
      @path_hashes[method][path].call env
    rescue
      begin
        #Regex mapping exists
        @path_hashes[method].select { |k,v| k.class == Regexp and k.match(path) }.values.first.call env
      rescue
        begin
          #Serve static file
          [200, {"Content-Type"=>"text/html"}, File.new(Dir.pwd+path, "r").read]
        rescue
            begin
              #Run :default code block
              @path_hashes[method][:default].call env
            rescue
              [404, {"Content-Type"=>"text/html"}, @path_hashes.to_s]
            end
        end
      end
    end
  end
end