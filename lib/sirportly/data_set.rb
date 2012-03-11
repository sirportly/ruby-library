module Sirportly
  class DataSet < Array
  
    def initialize(records, klass)
      @pagination = {}
      if records.is_a?(Hash)
        @pagination = records['pagination']
        records = records['records']
      end

      records.map! do |r|
        if klass.maps
          for key, klass_name in klass.maps
            if r[key].is_a?(Array)
              r[key] = r[key].map { |p| Sirportly.const_get(klass_name).new(p) }
            elsif r[key].is_a?(Hash)
              r[key] = Sirportly.const_get(klass_name).new(r[key])
            end
          end
        end
      
        klass.new(r)
      end

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
