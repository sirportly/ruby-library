module Sirportly
  class Customer < DataObject
    self.collection_path = 'customers/all'
    self.member = {:path => 'customers/info', :param => 'customer'}
    self.maps = {'contact_methods' => 'CustomerContactMethod'}
  end
end
