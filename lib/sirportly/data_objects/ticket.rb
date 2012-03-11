module Sirportly
  class Ticket < DataObject
    self.collection_path = 'tickets/all'
    self.member = {:path => 'tickets/ticket', :param => 'reference'}
    self.maps = {'status' => 'Status', 'priority' => 'Priority', 'department' => 'Department', 'customer' => 'Customer', 'customer_contact_method' => 'CustomerContactMethod',
      'team' => 'Team', 'user' => 'User', 'sla' => 'SLA', 'updates' => 'TicketUpdate'}
    
    def run_macro(name_or_id)
      if req = client.request('tickets/macro', :ticket => @attributes['reference'], :macro => name_or_id)
        set_attributes(req)
        true
      else
        false
      end
    end
    
    def update(params)      
      if req = client.request('tickets/update', format_params(params))
        set_attributes(req)
        true
      else
        false
      end
      
    end
    
    def post_update(params = {})
      if req = client.request('tickets/post_update', format_params(params))
        update = TicketUpdate.new(@client, req)
        @attributes['updates'] << update
        update
      else
        false
      end
    end
    
    private
    
    def format_params(params)
      params.inject({:ticket => @attributes['reference']}) do |hash, (k,v)|
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
