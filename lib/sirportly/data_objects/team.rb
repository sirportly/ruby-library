module Sirportly
  class Team < DataObject
    self.collection_path = 'objects/teams'
    self.maps = {'users' => 'User'}
  end
end
