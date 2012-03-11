module Sirportly
  class TicketUpdate < DataObject
    
    def author
      if author = self.attributes['author']
        if author.keys.include?('reference') && author.keys.include?('abbreviated_name') && author.keys.include?('pin')
          Customer.new(author)
        else
          User.new(author)
        end
      else
        nil
      end
    end
    
  end
end
