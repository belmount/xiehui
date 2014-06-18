class HomeController < ApplicationController
  def index
    @news = News.last5
  end

  def control
    render layout: 'application'
  end

  def category
    @cat = Category.where(ename: params[:first_cat]).first
    @pages= @cat.sub_categories.first.pages
    render layout: 'application'
  end

  def sub_cat
    @cat = Category.where(ename: params[:first_cat]).first
    render 'category', layout: 'application'
  end

  def page
    render layout: 'application'
  end
end
