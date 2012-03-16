module Sirportly
  class SPQLQuery
    
    attr_reader :query
    
    def initialize(client, query)
      @client, @query = client, query
      execute
    end
    
    def fields
      @result['fields']
    end
    
    def results
      @result['results']
    end
    
    def execute
      if req = @client.request('tickets/spql', :spql => @query)
        @result = req
      else
        false
      end
    end
    
  end
end
