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
    
    def post_update(params = {})
      params.merge!({:ticket => @attributes['reference']})
      
      if (params[:user] || params['user']).is_a?(Sirportly::User)
        params[:user] = (params[:user] || params['user']).id
        params.delete('user')
      end
      
      if (params[:customer] || params['customer']).is_a?(Sirportly::Customer)
        params[:customer] = (params[:customer] || params['customer']).id
        params.delete('customer')
      end
      
      if req = client.request('tickets/post_update', params)
        update = TicketUpdate.new(@client, req)
        @attributes['updates'] << update
        update
      else
        false
      end
    end
        
  end
end
