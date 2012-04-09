module Sirportly
  class Page < DataObject
    self.maps = {'children' => 'Page'}
    
    def has_children?
      !self.children.empty?
    end
  end
end