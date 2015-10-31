class ContentsController < ApplicationController
  respond_to :js, :html, :json
  before_filter :require_login

  def new
    @content = Content.new
    @content.parent_id = params[:parent_id]
    
    respond_with @content
  end

  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id

    @content.ancestry = params[:content][:parent_id].empty? ? nil : params[:content][:parent_id]
    if params[:content]['attachment']
      @image = Image.create!(:attachment => params[:content]['attachment'])
      @content.image = @image
    end
    

    if @content.save
      redirect_url = contents_url
      flash[:success] = "New content posted!" if !request.xhr?

      unless params[:content][:parent_id].empty?
        redirect_url = content_url(@content.ancestry)
        flash[:success] = 'Comment Posted!' if !request.xhr?
      end
      
    end

    respond_with(@content, :location => redirect_url)
  end

  def index
    @user = current_user
    @title = "Discussions"
    @embed_post_link = "New Discussion";
    @content = Content.new

    @contents = Content.order('created_at DESC')

    @contents = @contents.where({ancestry: nil})
    

    respond_with @content
  end

  def onboard
    @user = current_user
  end

  def show
    @content = Content.find(params[:id])
    @reply = Content.new
    @title = @content.title
    @subtitle = "From " + @content.user.nickname + ". on " + @content.created_at.strftime("%Y-%m-%d")

    @user = current_user
    @embed_reply = true

    if @content.ancestry
      redirect_to content_url(@content.ancestry)
    end
    

    respond_with @content
  end

  def edit
    @content = Content.find(params[:id])

    @title = @content.ancestry ? 'Edit Comment' : 'Edit Post'
    

    respond_with @content
  end

  def update
    @content = Content.find(params[:id])
    
    if @content.update_attributes(content_params)
      flash[:success] = "Post Updated!" if !request.xhr?
    end

    

    respond_with @content
  end

  def content_params
    params.require(:content).permit(
      :image_src, 
      
      
      :description,
      :title
    )
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_with @content
  end

  def create_reply
    create
  end
  
end
