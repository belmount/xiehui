class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy,:register_finished]
  before_action :authenticate_user!, except:[:new, :create]
  authorize_resource
  layout "categories", except: [:new, :register_finished]
  # GET /students
  # GET /students.json
  def index
    if params[:type].present? 
      if params[:type]=='noc' 
        @students = Student.no_score.no_course.page params[:page]
      else
        @students = Student.no_score.with_course.page params[:page]
      end
    else
      @students = Student.no_score.page params[:page]
    end
  end

  def search
    @students = Student.with_id(params[:id_num]).with_nth(params[:nth]).with_name(params[:name]).with_company(params[:company])
  end

  def score
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to register_finished_url(@student), notice: '注册成功.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def register_finished
  end

  def join_course
    if params[:todo] == 'cancel'
      logger.info 'cancel reached' 
      if Student.where(id: params[:sid]).update_all(course_id: nil)
        render text: '关联取消成功,请点击以上按钮刷新页面'
      else
        render text: '关联取消失败'
      end
    elsif Student.where(id: params[:sid]).update_all(course_id: params[:course]) 
      render text:'已完成关联,请点击以上按钮刷新页面'
    else
      render text:'关联失败'
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: '该报名信息已删除.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :tel, :gender, :education, :company_name, :company_code, :id_code, :district, :school, :school_cert)
    end
end
