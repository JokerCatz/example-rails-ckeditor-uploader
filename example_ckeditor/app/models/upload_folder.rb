class UploadFolder < Upload
  has_many :child , :foreign_key => :parent_id , :class_name => 'Upload' , :dependent => :destroy
end