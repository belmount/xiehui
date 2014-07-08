require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { company_code: @student.company_code, company_name: @student.company_name, district: @student.district, education: @student.education, gender: @student.gender, id_code: @student.id_code, name: @student.name, school: @student.school, school_cert: @student.school_cert, tel: @student.tel }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    patch :update, id: @student, student: { company_code: @student.company_code, company_name: @student.company_name, district: @student.district, education: @student.education, gender: @student.gender, id_code: @student.id_code, name: @student.name, school: @student.school, school_cert: @student.school_cert, tel: @student.tel }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
