require 'test_helper'

class ParentsControllerTest < ActionController::TestCase
  setup do
    @parent = parents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parent" do
    assert_difference('Parent.count') do
      post :create, parent: { address_1: @parent.address_1, address_2: @parent.address_2, alternate_email: @parent.alternate_email, care_provider: @parent.care_provider, care_provider_phone: @parent.care_provider_phone, cell_phone: @parent.cell_phone, city: @parent.city, comments: @parent.comments, doctor: @parent.doctor, doctor_phone: @parent.doctor_phone, email: @parent.email, emergency_contact: @parent.emergency_contact, emergency_contact_phone: @parent.emergency_contact_phone, first_name: @parent.first_name, home_phone: @parent.home_phone, insurance: @parent.insurance, insurance_phone: @parent.insurance_phone, last_name: @parent.last_name, policy_number: @parent.policy_number, state: @parent.state, work_phone: @parent.work_phone, zip: @parent.zip }
    end

    assert_redirected_to parent_path(assigns(:parent))
  end

  test "should show parent" do
    get :show, id: @parent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parent
    assert_response :success
  end

  test "should update parent" do
    put :update, id: @parent, parent: { address_1: @parent.address_1, address_2: @parent.address_2, alternate_email: @parent.alternate_email, care_provider: @parent.care_provider, care_provider_phone: @parent.care_provider_phone, cell_phone: @parent.cell_phone, city: @parent.city, comments: @parent.comments, doctor: @parent.doctor, doctor_phone: @parent.doctor_phone, email: @parent.email, emergency_contact: @parent.emergency_contact, emergency_contact_phone: @parent.emergency_contact_phone, first_name: @parent.first_name, home_phone: @parent.home_phone, insurance: @parent.insurance, insurance_phone: @parent.insurance_phone, last_name: @parent.last_name, policy_number: @parent.policy_number, state: @parent.state, work_phone: @parent.work_phone, zip: @parent.zip }
    assert_redirected_to parent_path(assigns(:parent))
  end

  test "should destroy parent" do
    assert_difference('Parent.count', -1) do
      delete :destroy, id: @parent
    end

    assert_redirected_to parents_path
  end
end
