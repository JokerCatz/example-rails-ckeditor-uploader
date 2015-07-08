class Upload < ActiveRecord::Base
  belongs_to :parent , :class_name => 'UploadFolder'
  #STI as int #http://jokercatz.blogspot.tw/2015/02/rails-sti-type-be-int.html
  #不使用 type = String的欄位，用int來加速搜尋，還可以加非String的index
    ALLOWED_CLASSES = ['UploadFolder' , 'UploadImage']
    def self.find_sti_class type_name
      ALLOWED_CLASSES[type_name.to_i].constantize
    rescue NameError, TypeError
      super
    end
    def self.sti_name
      ALLOWED_CLASSES.index(self.name)
    end
  #/STI

  #找到所有老爸，爺爺，祖宗s 的列表（圖片和資料夾都可以使用此method）
  def parents
    source = []
    flag = self.parent
    counter = 0
    while counter < 20 && flag
      counter += 1
      source << flag
      flag = flag.parent
    end
    return source
  end
end
