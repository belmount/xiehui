class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 
  authorize_resource
  layout "categories"

  # GET /pages
  # GET /pages.json
  def index
    if params[:edit_s] or params[:edit_e] or params[:title] or params[:page_type] then
      e = DateTime.current
      s = nil
      if params[:edit_s] and params[:edit_e] then
        e = params[:edit_e].to_datetime
        s = params[:edit_s].to_datetime
      end
      type ||= Category.find(params[:page_type])
      @pages = Page.with_title(params[:title]).within_date(s, e).with_type(type).page params[:page]
    else
      @pages = Page.all.page params[:page]
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    flash[:p] = params[:p]
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to pages_url(page: flash[:p]), notice: '页面已经更新成功' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url(page: params[:page]), notice: '页面已成功删除.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :content, :edit_at, :category_id)
    end
end
