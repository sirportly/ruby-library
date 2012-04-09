module Sirportly
  class KnowledgeBase < DataObject    
    self.collection_path = 'knowledge/list'
    
    ## An array of all pages within a knowledge base
    attr_reader :pages
    
    def initialize(client, attributes = {})
      super
      @pages = retrieve_pages
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
    
    private
    
    ## Returns a tree of all the pages in a knowledge base
    def retrieve_pages
      ## Prevent multiple requests if already cached
      return @pages if @pages
      if req = @client.request('knowledge/tree', {:kb => self.attributes['id']})
        pages_from_tree req.first['children']
      else
        false
      end
    end
    
    ## Transforms a tree of hashes in Page objects
    def pages_from_tree(tree)
      tree.collect do |p|
        children = p.delete 'children'
        page = Page.new @client, p
        ## Recursively create Pages from the children
        page.children = pages_from_tree(children) unless children.nil?
        ## Collect the new Page object
        page
      end
    end
  end
end