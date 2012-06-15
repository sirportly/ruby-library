module Sirportly
  class KnowledgeBasePage < DataObject
    self.maps = {'children' => 'KnowledgeBasePage'}
    
    def has_children?
      !self.children.empty?
    end
    
  end
end