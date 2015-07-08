class UploadsController < ApplicationController
  def index #root
    @childs = Upload.where('parent_id IS NULL').order('type')
  end
  def show #in folder
    @folder = UploadFolder.where(:id => params[:id]).first
    @childs = Upload.where(:parent_id => @folder.id).order('type')
  end
  def create #for folder create
    #0 = root
    parent_folder = UploadFolder.where(:id => params[:id]).first if params[:id] && params[:id].to_i != 0
    upload = UploadFolder.create(:name => params[:name] , :parent_id => parent_folder ? parent_folder.id : nil)
    raise Exception.new(upload.errors.full_messages) unless upload.errors.empty?
    redirect_to :back
  end
  def upload #for image upload
    #0 = root
    parent_folder = UploadFolder.where(:id => params[:id]).first if params[:id] && params[:id].to_i != 0
    upload = UploadImage.create(:image => params[:image] , :parent_id => parent_folder ? parent_folder.id : nil)
    raise Exception.new(upload.errors.full_messages) unless upload.errors.empty?
    redirect_to :back
  end
  def destroy #for both
    @upload = Upload.find(params[:id])
    @upload.destroy
    if @upload.is_a?(UploadFolder)
      if @upload.parent_id
        redirect_to :action => :show , :id => @upload_parent_id
      else
        redirect_to :action => :index
      end
    else #image
      redirect_to :back
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
