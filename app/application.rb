class Application
  
  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
  
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      if item =@@items.find{|i| i.name == item_name}
        resp.write item.price
        # If a user requests /items/<Item Name> it should return the 
        # price of that item
      else 
        resp.status = 400
        resp.write "Item not found"
        # IF a user requests an item that you don't have, 
        # then return a 400 and an error message
      end
    else
      resp.status=404
      resp.write "Route not found"
      # Your application should only accept the /items/<ITEM NAME> route. 
      # Everything else should 404
    end
    resp.finish
  end

end