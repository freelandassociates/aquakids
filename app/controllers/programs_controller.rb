class ProgramsController < ApplicationController
  filter_access_to :all
  filter_access_to :payment_plansForSchedule, :require => :show

  # GET /programs
  # GET /programs.json
  def index
    @programs = Program.all(:order => :id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programs, root: false   }
    end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = Program.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(params[:program])

    respond_to do |format|
      if @program.save
        format.html { redirect_to programs_url, notice: 'Program was successfully created.' }
        format.json { render json: @program, status: :created, location: @program }
      else
        format.html { render action: "new" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = Program.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to programs_url, notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :no_content }
    end
  end

  def payment_plansForSchedule
    # Find all payment_plans for the given program_id..
    @schedule = Schedule.find(params[:schedule_id])
    # binding.pry
    # @payment_plans = PaymentPlan.find_by_program_id(@schedule.program_id)
    @payment_plans = PaymentPlan.find(:all, :conditions => {:program_id => @schedule.program_id})
    # binding.pry

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment_plans }
    end
  end

end
