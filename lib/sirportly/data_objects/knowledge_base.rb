module Sirportly
  class KnowledgeBase < DataObject    
    self.collection_path = 'knowledge/list'
    self.member = {:path => 'knowledge/tree', :param => :kb}
    self.maps = {'children' => 'Page'}
    
    ## Workaround for a Sirportly bug
    ## Currently SP wraps the result in an array
    def self.find(client, query)
      raise Sirportly::Error, "This object does not support finding objects" unless member.is_a?(Hash)
      result = client.request(member[:path], {member[:param] => query})
      ## Notice .first here
      self.new(client, result.first)
    end
    
    def pages
      self.children
    end
    
    ## Creates a new page associated with this knowledge base
    ## Returns a Page object
    def create_page(params = {})
      params.merge!({:kb => self.attributes['id']})
      if req = @client.request('knowledge/add_page', params)
        Page.new @client, req
      else
        false
      end
    end
  end
end