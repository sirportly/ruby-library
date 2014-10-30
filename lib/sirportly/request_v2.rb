module Sirportly
  class RequestV2 < Request
    
    def self.request(client, path, data = {})
      req = self.new(client, path, :post)
      req.data = data
      req.make && req.success? ? req.output : false
    end

    def api_version
      @api_version ||= 'api/v2'
    end
  end
end
