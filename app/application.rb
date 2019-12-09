require 'pry'
class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            search_term = req.path.split('/items/').last
            in_stock = nil
            @@items.each do |item| 
                if item.name == search_term
                    resp.write item.price
                    in_stock = true
                end

            end
            if in_stock == nil
              resp.write "Item not found"
              resp.status = 400
            end

        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end