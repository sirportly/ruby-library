module Sirportly
  class SupportCentre < DataObject
    self.collection_path = 'support_centres/list'

    ## request an auth token for support centre, allowing to authenticate a user
    def auth_token(opts = {})
      if req = client.request_v2('authentication/support_centre_token', opts.merge(:support_centre => self.id))
        req
      else
        false
      end
    end

    def redirect_uri(support_centre_token)
      support_centre_token = if support_centre_token.is_a?(Hash)
                               support_centre_token['token']
                             end

      URI.parse([self.access_domain_with_protocol, 'login', support_centre_token].join('/')).to_s
    end
  end
end
