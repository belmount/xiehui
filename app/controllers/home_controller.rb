class HomeController < ApplicationController
  def index
    @news = News.last5
  end

  def control
    render layout: 'application'
  end
end
