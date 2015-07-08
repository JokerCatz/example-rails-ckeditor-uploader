class UploadImage < Upload
  #上傳設定 #http://railsfun.tw/t/paperclip/64
    has_attached_file :image ,
      :styles => {:original => ['1024x768>' , :jpg] , :thumb => ['120x120#' , :jpg]},
      :convert_options => {
        :original => '-colorspace sRGB -quality 90' , :thumb => '-colorspace sRGB -quality 90'
      },
      :path => ":rails_root/public/uploads/image/:style/:id_:fingerprint.:extension",
      :url => "/uploads/image/:style/:id_:fingerprint.:extension"
    do_not_validate_attachment_file_type :image
    attr_accessor :image_content_type #fake method
    #rename obj.name to image_file_name
    def image_file_name ; return self.name ; end
    def image_file_name=(source) ; return self.name = source ; end
  #/上傳設定
  validates :parent, :presence => true #圖片一定要在某個資料夾內，否則不給新增
end
