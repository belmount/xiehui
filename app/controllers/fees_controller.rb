class FeesController < ApplicationController
  before_action :set_member
  before_action :set_fee, only: [ :edit, :update, :destroy]

  layout 'categories'
  
  # GET /fees
  # GET /fees.json
  def index
    @fees = @member.fees
  end

  # GET /fees/new
  def new
    @fee = @member.fees.build
  end

  # GET /fees/1/edit
  def edit
  end

  # POST /fees
  # POST /fees.json
  def create
    @fee =  @member.fees.build(fee_params)

    respond_to do |format|
      if @fee.save
        format.html { redirect_to member_fees_url(@member), notice: '缴费生成' }
        format.json { render :show, status: :created, location: @fee }
      else
        format.html { render :new }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to member_fees_url(@member), notice: '缴费更新.' }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to member_fees_url(@member), notice: '缴费删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    def set_member
      @member = Member.find(params[:member_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:year, :pay_at, :member)
    end
end
