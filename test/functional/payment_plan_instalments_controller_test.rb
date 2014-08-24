require 'test_helper'

class PaymentPlanInstalmentsControllerTest < ActionController::TestCase
  setup do
    @payment_plan_instalment = payment_plan_instalments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_plan_instalments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_plan_instalment" do
    assert_difference('PaymentPlanInstalment.count') do
      post :create, payment_plan_instalment: { due_date: @payment_plan_instalment.due_date, payment_amount: @payment_plan_instalment.payment_amount, payment_plan_id: @payment_plan_instalment.payment_plan_id }
    end

    assert_redirected_to payment_plan_instalment_path(assigns(:payment_plan_instalment))
  end

  test "should show payment_plan_instalment" do
    get :show, id: @payment_plan_instalment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_plan_instalment
    assert_response :success
  end

  test "should update payment_plan_instalment" do
    put :update, id: @payment_plan_instalment, payment_plan_instalment: { due_date: @payment_plan_instalment.due_date, payment_amount: @payment_plan_instalment.payment_amount, payment_plan_id: @payment_plan_instalment.payment_plan_id }
    assert_redirected_to payment_plan_instalment_path(assigns(:payment_plan_instalment))
  end

  test "should destroy payment_plan_instalment" do
    assert_difference('PaymentPlanInstalment.count', -1) do
      delete :destroy, id: @payment_plan_instalment
    end

    assert_redirected_to payment_plan_instalments_path
  end
end
