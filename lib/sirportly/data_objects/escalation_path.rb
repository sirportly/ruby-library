module Sirportly
  class EscalationPath < DataObject
    self.collection_path = 'objects/escalation_paths'
    self.maps = {'teams' => 'Team'}
  end
end
