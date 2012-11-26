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
    
    ## Creates a new ticket
    def create_ticket(params = {})
      Ticket.create(self, params)
    end
    
    ## Return all customers
    def customers(opts = {})
      Customer.all(self, opts)
    end
    
    ## Return a specific customer
    def customer(q)
      Customer.find(self, q)
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
    
    ## Return all knowledge bases
    def knowledge_bases
      KnowledgeBase.all(self)
    end
    
    ## Return a specific knowledge base
    def knowledge_base(q)
      KnowledgeBase.find(self, q)
    end
    
    ## Return all priorities
    def priorities
      Priority.all(self)
    end
    
    ## Return all SLAs
    def slas
      SLA.all(self)
    end
    
    ## Return all custom fields
    def custom_fields
      CustomField.all(self)
    end
    
    ## Execute an SPQL query and return the SPQLQuery instance
    def spql(query)
      SPQLQuery.new(self, query)
    end
    
    ## Return all statuses
    def statuses
      Status.all(self)
    end
    
    ## Return all teams
    def teams
      Team.all(self)
    end
    
    ## Return all tickets
    def tickets
      Ticket.all(self)
    end
    
    ## Return a specific ticket
    def ticket(q)
      Ticket.find(self, q)
    end
    
    ## Return a set of tickets for given search term
    def ticket_search(query, page = 1)
      Ticket.search(self, query, page)
    end
    
    ## Return all users
    def users(opts = {})
      User.all(self, opts)
    end
    
    ## Return a specific user
    def user(q)
      User.find(self, q)
    end
    
    ## Create a user
    def create_user(params = {})
      User.create(self, params)
    end
    
  end
end
