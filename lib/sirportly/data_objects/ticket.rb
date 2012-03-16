module Sirportly
  class Ticket < DataObject
    self.collection_path = 'tickets/all'
    self.member = {:path => 'tickets/ticket', :param => 'reference'}
    self.maps = {'status' => 'Status', 'priority' => 'Priority', 'department' => 'Department', 'customer' => 'Customer', 'customer_contact_method' => 'CustomerContactMethod',
      'team' => 'Team', 'user' => 'User', 'sla' => 'SLA', 'updates' => 'TicketUpdate'}
    
    # Executes a macro on the ticket. Accepts the name of ID of the macro you wish to execute as a 
    # string or an integer.
    def run_macro(name_or_id)
      if req = client.request('tickets/macro', :ticket => @attributes['reference'], :macro => name_or_id.to_s)
        set_attributes(req)
        true
      else
        false
      end
    end
    
    # Updates ticket parameters. Accepts a hash with the parameters which you wish to update.
    def update(params)      
      if req = client.request('tickets/update', format_params(params))
        set_attributes(req)
        true
      else
        false
      end
    end
    
    # Posts a new update to the ticket. Accepts a hash of parameters needed to create the update.
    def post_update(params = {})
      if req = client.request('tickets/post_update', format_params(params))
        update = TicketUpdate.new(@client, req)
        (@attributes['updates'] ||= []) << update
        update
      else
        false
      end
    end
    
    # Creates a new ticket and returns a ticket object
    def self.create(client, params = {})
      if req = client.request('tickets/submit', format_params(params))
        self.new(client, req)
      else
        false
      end
    end
    
    # Returns a DataSet containing tickets matching the passed query and page number.
    def self.search(client, query, page = 1)
      if req = client.request('tickets/search', :query => query, :page => page)
        DataSet.new(client, req, self)
      else
        false
      end
    end
    
    # Returns tickets which match the passed filter
    def self.filter(client, filter, options = {})
      filter = filter.id if filter.is_a?(Sirportly::Filter)
      options[:user] = options[:user].id if options[:user].is_a?(Sirportly::User)
      if req = client.request('tickets/filter', options.merge({:filter => filter}))
        DataSet.new(client, req, self)
      else
        false
      end
    end
    
    private
    
    def format_params(params)
      self.class.format_params(params.merge({:ticket => @attributes['reference']}))
    end
    
    def self.format_params(params)
      params.inject({}) do |hash, (k,v)|
        if v.kind_of?(Sirportly::DataObject) && v.attributes.keys.include?('id')
          hash[k] = v.id
        else
          hash[k] = v
        end
        hash
      end
    end
        
  end
end
