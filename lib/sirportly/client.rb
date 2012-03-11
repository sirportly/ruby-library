module Sirportly
  class Client
    
    attr_reader :token, :secret
    
    def initialize(token, secret)
      @token, @secret = token, secret
    end
    
    ## Make a request using this client's authentication token and return the request.
    def request(*args)
      Request.request(self, *args)
    end
    
    ## Return all brands
    def brands
      Brand.all(self)
    end
    
    ## Return all departments
    def departments
      Department.all(self)
    end
    
    ## Return all escalation paths
    def escalation_paths
      EscalationPath.all(self)
    end
    
    ## Return all filters
    def filters
      Filter.all(self)
    end
    
    ## Return all priorities
    def priorities
      Priority.all(self)
    end
    
    ## Return all SLAs
    def slas
      SLA.all(self)
    end
    
    ## Return all statuses
    def statuses
      Status.all(self)
    end
    
    ## Return all teams
    def teams
      Team.all(self)
    end
    
    ## Return all users
    def users(opts = {})
      User.all(self, opts)
    end
    
  end
end
