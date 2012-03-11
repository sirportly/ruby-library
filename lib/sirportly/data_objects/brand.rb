module Sirportly
  class Brand < DataObject
    self.collection_path = 'objects/brands'
    self.maps = {'departments' => "Department"}
  end
end
