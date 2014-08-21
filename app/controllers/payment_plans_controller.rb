class PaymentPlansController < ApplicationController
  # GET /payment_plans
  # GET /payment_plans.json
  def index
    @payment_plans = PaymentPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_plans }
    end
  end

  # GET /payment_plans/1
  # GET /payment_plans/1.json
  def show
    @payment_plan = PaymentPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plan }
    end
  end

  # GET /payment_plans/new
  # GET /payment_plans/new.json
  def new
    @payment_plan = PaymentPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment_plan }
    end
  end

  # GET /payment_plans/1/edit
  def edit
    @payment_plan = PaymentPlan.find(params[:id])
  end

  # POST /payment_plans
  # POST /payment_plans.json
  def create
    @payment_plan = PaymentPlan.new(params[:payment_plan])

    respond_to do |format|
      if @payment_plan.save
        format.html { redirect_to @payment_plan, notice: 'Payment plan was successfully created.' }
        format.json { render json: @payment_plan, status: :created, location: @payment_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @payment_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payment_plans/1
  # PUT /payment_plans/1.json
  def update
    @payment_plan = PaymentPlan.find(params[:id])

    respond_to do |format|
      if @payment_plan.update_attributes(params[:payment_plan])
        format.html { redirect_to @payment_plan, notice: 'Payment plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_plans/1
  # DELETE /payment_plans/1.json
  def destroy
    @payment_plan = PaymentPlan.find(params[:id])
    @payment_plan.destroy

    respond_to do |format|
      format.html { redirect_to payment_plans_url }
      format.json { head :no_content }
    end
  end
end
