class HomeController < ApplicationController
  def index
    news_cat = Category.where(ename: 'news').first
    if news_cat 
      @news = Page.where(category: news_cat.sub_categories).limit(5)
    else
      @news = []
    end
  end

  def control
    render layout: 'application'
  end

  def category
    @cat = Category.where(ename: params[:first_cat]).first
  
    if params[:second_cat].present?
      @sub =  @cat.sub_categories.where(ename:params[:second_cat]).first
    else
      @sub = @cat.sub_categories.first
    end

    if @cat.has_url? 
      @url = @cat.url
      return redirect_to @url
    elsif @sub.has_url?
      @url = @sub.url
      session[:cat]=@cat.id
      session[:sub]=@sub.id
      return redirect_to @url
    end
    if (@sub && params[:pid].present?)
      @pid = params[:pid]
      @pages = Page.where(id: @pid)
    elsif  @sub then
      @pages= @sub.pages
    else
      @pages=[]
    end
    render layout: 'application'
  end

  def page
    render layout: 'application'
  end
end
