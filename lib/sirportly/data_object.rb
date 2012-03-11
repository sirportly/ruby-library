module Sirportly
  class DataObject
    
    class << self
      attr_accessor :api_path
      attr_accessor :maps
      
      def all(client, options = {})
        result = client.request(api_path, :page => options[:page] || 1)
        DataSet.new(result, self)
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
        
  end
end
