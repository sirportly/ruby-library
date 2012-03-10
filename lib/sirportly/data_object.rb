module Sirportly
  class DataObject
    
    class << self
      attr_accessor :api_path
      attr_accessor :maps
      
      def all(options = {})
        result = Request.request(api_path, :page => options[:page] || 1)
        Set.new(result, self)
      end
      
      def first
        all(:page => 1).first
      end
      
    end
    
    attr_reader :attributes
    
    def initialize(attributes = {})
      @attributes = attributes
    end
    
    def inspect
      "#<#{self.class.to_s} #{attributes.inspect}>"
    end
    
    def method_missing(name)
      if attributes.keys.include?(name.to_s)
        attributes[name.to_s]
      else
        super
      end
    end
    
    class Set < Array
      
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
end
