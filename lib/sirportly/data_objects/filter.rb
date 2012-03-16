module Sirportly
  class Filter < DataObject
    self.collection_path = 'objects/filters'
    
    def tickets(options = {})
      Ticket.filter(@client, self, options)
    end
    
  end
end
