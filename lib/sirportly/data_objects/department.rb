module Sirportly
  class Department < DataObject
    self.collection_path = 'objects/departments'
    self.maps = {'brand' => 'Brand', 'escalation_path' => 'EscalationPath'}
  end
end
