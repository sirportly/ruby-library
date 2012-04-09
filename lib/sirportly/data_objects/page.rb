module Sirportly
  class Page < DataObject
    attr_accessor :children
    
    def has_children?
      !@children.empty?
    end
  end
end