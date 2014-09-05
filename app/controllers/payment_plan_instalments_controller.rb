class PaymentPlanInstalmentsController < ApplicationController
  filter_resource_access
  
  # GET /payment_plan_instalments
  # GET /payment_plan_instalments.json
  def index
    # @payment_plan_instalments = PaymentPlanInstalment.joins(:payment_plan).order('payment_plans.id, due_date').all
    if (params[:payment_plan])
      @payment_plan_instalments = PaymentPlanInstalment.joins(:payment_plan).order('payment_plans.id, due_date').find(:all, :conditions => {:payment_plan_id => params[:payment_plan]})
    else
      @payment_plan_instalments = PaymentPlanInstalment.joins(:payment_plan).order('payment_plans.id, due_date').all
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payment_plan_instalments }
    end
  end

  # GET /payment_plan_instalments/1
  # GET /payment_plan_instalments/1.json
  def show
    @payment_plan_instalment = PaymentPlanInstalment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plan_instalment }
    end
  end

  # GET /payment_plan_instalments/new
  # GET /payment_plan_instalments/new.json
  def new
    @payment_plan_instalment = PaymentPlanInstalment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment_plan_instalment }
    end
  end

  # GET /payment_plan_instalments/1/edit
  def edit
    @payment_plan_instalment = PaymentPlanInstalment.find(params[:id])
  end

  # POST /payment_plan_instalments
  # POST /payment_plan_instalments.json
  def create
    @payment_plan_instalment = PaymentPlanInstalment.new(params[:payment_plan_instalment])

    respond_to do |format|
      if @payment_plan_instalment.save
        format.html { redirect_to @payment_plan_instalment, notice: 'Payment plan instalment was successfully created.' }
        format.json { render json: @payment_plan_instalment, status: :created, location: @payment_plan_instalment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment_plan_instalment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payment_plan_instalments/1
  # PUT /payment_plan_instalments/1.json
  def update
    @payment_plan_instalment = PaymentPlanInstalment.find(params[:id])

    respond_to do |format|
      if @payment_plan_instalment.update_attributes(params[:payment_plan_instalment])
        format.html { redirect_to @payment_plan_instalment, notice: 'Payment plan instalment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment_plan_instalment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_plan_instalments/1
  # DELETE /payment_plan_instalments/1.json
  def destroy
    @payment_plan_instalment = PaymentPlanInstalment.find(params[:id])
    @payment_plan_instalment.destroy

    respond_to do |format|
      format.html { redirect_to payment_plan_instalments_url }
      format.json { head :no_content }
    end
  end
end
