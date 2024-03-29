class ContentsController < ApplicationController
  respond_to :js, :html, :json
  before_filter :require_login

  def new
    @no_turbo = true
    @content = Content.new
    @content.parent_id = params[:parent_id]
    
    respond_with @content
  end

  def create
    @content = Content.new(content_params)
    @content.user_id = current_user.id

    # TODO: code this later to allow comments and follow up content.
    @content.ancestry = params[:content][:parent_id].empty? ? nil : params[:content][:parent_id]
    if params[:content]['attachment']
      @image = Image.create!(:attachment => params[:content]['attachment'])
      @content.image = @image
    end
    

    if @content.save
      redirect_url = content_url(@content)
      flash[:success] = "New content posted!" if !request.xhr?

      unless params[:content][:parent_id].empty?
        redirect_url = content_url(@content.ancestry)
        flash[:success] = 'Comment Posted!' if !request.xhr?
      end
      
    end

    respond_with(@content, :location => redirect_url)
  end

  def index
    @active = "products"
    @user = current_user
    @contents = @user.contents.order('created_at DESC')
    if @contents.length == 0
      redirect_to onboard_url, data: { no_turbolink: true }
    else
      @contents = @contents.where({ancestry: nil})
      respond_with @content
    end
  end

  def orders
    @active = "orders"
  end

  def onboard
    @no_turbo = true
    @user = current_user
    @content = Content.new

    respond_with @content
  end

  def show
    @twitter_css = true
    @content = Content.find(params[:id])
    @reply = Content.new

    @user = current_user
    @embed_reply = true
    if @user != @content.user
      redirect_to contents_url
    else
      if @content.ancestry
        redirect_to content_url(@content.ancestry)
      end
      respond_with @content
    end
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
      :price,
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
