module Sirportly
  class Ticket < DataObject
    self.collection_path = 'tickets/all'
    self.member = {:path => 'tickets/ticket', :param => 'reference'}
    self.maps = {'status' => 'Status', 'priority' => 'Priority', 'department' => 'Department', 'customer' => 'Customer', 'customer_contact_method' => 'CustomerContactMethod',
      'team' => 'Team', 'user' => 'User', 'sla' => 'SLA', 'updates' => 'TicketUpdate'}
          
  end
end
