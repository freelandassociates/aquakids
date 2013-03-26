require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
  setup do
    @teacher = teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher" do
    assert_difference('Teacher.count') do
      post :create, teacher: { address_1: @teacher.address_1, address_2: @teacher.address_2, cell_phone: @teacher.cell_phone, city: @teacher.city, email: @teacher.email, first_name: @teacher.first_name, home_phone: @teacher.home_phone, last_name: @teacher.last_name, middle_name: @teacher.middle_name, notes: @teacher.notes, state: @teacher.state, work_phone: @teacher.work_phone, zip: @teacher.zip }
    end

    assert_redirected_to teacher_path(assigns(:teacher))
  end

  test "should show teacher" do
    get :show, id: @teacher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher
    assert_response :success
  end

  test "should update teacher" do
    put :update, id: @teacher, teacher: { address_1: @teacher.address_1, address_2: @teacher.address_2, cell_phone: @teacher.cell_phone, city: @teacher.city, email: @teacher.email, first_name: @teacher.first_name, home_phone: @teacher.home_phone, last_name: @teacher.last_name, middle_name: @teacher.middle_name, notes: @teacher.notes, state: @teacher.state, work_phone: @teacher.work_phone, zip: @teacher.zip }
    assert_redirected_to teacher_path(assigns(:teacher))
  end

  test "should destroy teacher" do
    assert_difference('Teacher.count', -1) do
      delete :destroy, id: @teacher
    end

    assert_redirected_to teachers_path
  end
end
