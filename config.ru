require 'instadroid-server'

app = App.new
app.setup
app.create_routes
run app