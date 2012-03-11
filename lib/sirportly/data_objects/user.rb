module Sirportly
  class User < DataObject
    self.collection_path = 'users/all'
    self.member = {:path => 'users/info', :param => 'user'}
    self.maps = {'teams' => 'Team'}
  end
end
