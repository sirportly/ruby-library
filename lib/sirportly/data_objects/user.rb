module Sirportly
  class User < DataObject
    self.api_path = 'users/all'
    self.maps = {'teams' => 'Team'}
  end
end
