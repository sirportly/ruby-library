module Sirportly
  class ApiToken < DataObject
    self.collection_path = 'api_tokens/all'
    
    # Creates a new api token and returns an object
    def self.create(client, params = {})
      if req = client.request('api_tokens/create', params)
        self.new(client, req)
      else
        false
      end
    end
  end
end
