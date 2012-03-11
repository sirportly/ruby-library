module Sirportly
  class DataSet < Array
  
    def initialize(client, records, klass)
      @pagination = {}
      if records.is_a?(Hash)
        @pagination = records['pagination']
        records = records['records']
      end

      records.map! { |r| klass.new(client, r) }
      self.push(*records)
    end
  
    def page
      @pagination['page']
    end
  
    def total_records
      @pagination['total_records']
    end
  
    def per_page
      @pagination['per_page']
    end
  
    def pages
      @pagination['pages']
    end
  
    def offset
      @pagination['offset']
    end
  
  end
end
