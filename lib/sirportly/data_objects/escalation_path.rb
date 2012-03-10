module Sirportly
  class EscalationPath < DataObject
    self.api_path = 'objects/escalation_paths'
    self.maps = {'teams' => 'Team'}
  end
end
