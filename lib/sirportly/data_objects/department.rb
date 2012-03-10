module Sirportly
  class Department < DataObject
    self.api_path = 'objects/departments'
    self.maps = {'brand' => 'Brand', 'escalation_path' => 'EscalationPath'}
  end
end
