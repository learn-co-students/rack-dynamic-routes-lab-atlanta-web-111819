class Application


    def call(env)
        @resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            check_items(item_name)
        else
            @resp.write "Route not found"
            @resp.status = 404
        end
        @resp.finish
    end

    def check_items(user_item)
        temp = @@items.find{|itm| itm.name == user_item}
        if temp == nil
            @resp.write "Item not found"
            @resp.status = 400
        else
            @resp.write temp.price
        end

    end
end