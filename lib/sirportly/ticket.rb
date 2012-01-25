module Sirportly
  class Ticket
    
    class << self
    
      def find_by_reference(reference)
        Request.request('tickets/ticket', :reference => reference)
      rescue Errors::NotFound
        false
      end
    
      def execute_spql(query)
        Request.request('tickets/spql', :spql => query)
      end
      
      def submit(options)
        Request.request('tickets/submit', options)
      end
      
      def update(reference, options)
        options.merge!(:ticket => reference)
        Request.request('tickets/post_update', options)
      end
      
    end
  end
end
