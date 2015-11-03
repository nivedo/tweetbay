class SplashController < ApplicationController
  def index
    @splash_page = true
  end

  def howitworks
    @splash_page = true
    @content = Content.first
  end
  
  def aboutus
    @splash_page = true
  end
end
