class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :assoc_user]
  before_action :authenticate_user! 
  authorize_resource
  layout 'categories'
  # GET /members
  # GET /members.json
  def index
    @members = Member.name_with(params[:name]).page params[:page]

    respond_to do |format|
      format.html { render :index}
      format.xls {@members = Member.all}
      format.csv {send_data  Member.all.to_csv, filename: "会员-#{Time.now.strftime('%y%m%d%H%M%S')}.csv", type: "text/csv" }
    end
  end

  def feesum
    @fees= Fee.all
    respond_to do |format|
      format.xls {}
      format.csv {send_data  @fees.to_csv, filename: "缴费情况-#{Time.now.strftime('%y%m%d%H%M%S')}.csv", type: "text/csv" }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: '会员已创建.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: '会员已更新。' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: '会员已删除。' }
      format.json { head :no_content }
    end
  end

  def sel
    @members = Member.where('name like ?', "%#{params[:name]}%")
    render layout: false
  end

  def assoc_user
    uid = params[:uid].to_i
    if @member.update_attribute(:user_id , uid)
      redirect_to admin_user_url(@member.user), notice: '用户关联成功'
    else
      logger.info @member.errors[:user]
      redirect_to admin_user_url(@member.user), alert: '用户关联失败，请重新关联'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :address, :tel, :legal_person, :legal_tel, :contract, :contract_tel, :url, :logo, :mtype)
    end
end
