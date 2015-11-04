class SplashController < ApplicationController
  def index
    @splash_page = true
  end

  def howitworks
    @splash_page = true
    @twitter_css = true # Must include for twitter preview
    
    sample_params = {
      :image_src => "https://upload.wikimedia.org/wikipedia/commons/6/60/Matterhorn_from_Domh%C3%BCtte_-_2.jpg", 
      :price => 1.00,
      :description => "Cool mountains",
      :title => "Swiss Alps"
    }
    @content = Content.new(sample_params)
  end
  
  def aboutus
    @splash_page = true
  end
end
