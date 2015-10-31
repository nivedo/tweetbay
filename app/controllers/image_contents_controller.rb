class ImageContentsController < ApplicationController
  def create
    @image = Image.new(attachment: params[:file])
    if @image.save!
      respond_to do |format|
        format.json{ render :json => @image }
      end
    end
  end
end
