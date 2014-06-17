class HomeController < ApplicationController
  def index
    @news = News.last5
  	render layout: 'home'
  end

  def abount
  end
end
