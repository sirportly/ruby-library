module Sirportly
  class User < DataObject
    self.collection_path = 'users/all'
    self.member = {:path => 'users/info', :param => 'user'}
    self.maps = {'teams' => 'Team'}
    
    # Creates a new user and returns a user object
    def self.create(client, params = {})
      if req = client.request('users/create', params)
        self.new(client, req)
      else
        false
      end
    end
  end
end
