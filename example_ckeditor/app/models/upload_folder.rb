class UploadFolder < Upload
  #取得自己的孩子
  def childs
    return Upload.where(:parent_id => self.id)
  end
end
