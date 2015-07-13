module Sirportly
  class Attachment < DataObject

    # Fetch an attachment and return it
    def self.fetch(client, params = {})
      Sirportly.api_version = 'v2'
      req = client.request('tickets/attachment', params)
      Sirportly.api_version = 'v1'

      req ? req : false
    end
  end
end
