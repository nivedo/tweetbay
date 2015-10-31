

class ImagesController < ApplicationController
  def new
    @image = Image.new(key: params[:key])
  end
end

