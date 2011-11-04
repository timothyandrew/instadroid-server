require './lib/instadroid-server/framework'
require './lib/instadroid-server/app'

app = App.new
app.setup
run app