class UploadsController < ApplicationController
  def index #root
    @childs = UploadFolder.where('parent_id IS NULL')
  end
  def show #in folder
    @folder = UploadFolder.where(:id => params[:id])
    @childs = Upload.where(:parent_id => @folder.id)
  end
  def create #for folder create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Upload was successfully created.'
    else
      render :new
    end
  end
  def upload #for image upload
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
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
