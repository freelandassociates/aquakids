require 'test_helper'

class PaymentPlansControllerTest < ActionController::TestCase
  setup do
    @payment_plan = payment_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_plan" do
    assert_difference('PaymentPlan.count') do
      post :create, payment_plan: { name: @payment_plan.name, payment_plan_fee: @payment_plan.payment_plan_fee, per_lesson_cost: @payment_plan.per_lesson_cost }
    end

    assert_redirected_to payment_plan_path(assigns(:payment_plan))
  end

  test "should show payment_plan" do
    get :show, id: @payment_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_plan
    assert_response :success
  end

  test "should update payment_plan" do
    put :update, id: @payment_plan, payment_plan: { name: @payment_plan.name, payment_plan_fee: @payment_plan.payment_plan_fee, per_lesson_cost: @payment_plan.per_lesson_cost }
    assert_redirected_to payment_plan_path(assigns(:payment_plan))
  end

  test "should destroy payment_plan" do
    assert_difference('PaymentPlan.count', -1) do
      delete :destroy, id: @payment_plan
    end

    assert_redirected_to payment_plans_path
  end
end
