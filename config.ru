require './lib/instadroid-server/framework'
require './lib/instadroid-server/api'

app = API.new
app.setup
run app