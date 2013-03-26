class ParentsController < ApplicationController
  # GET /parents
  # GET /parents.json
  def index
    @parents = Parent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parents }
    end
  end

  # GET /parents/1
  # GET /parents/1.json
  def show
    @parent = Parent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parent }
    end
  end

  # GET /parents/new
  # GET /parents/new.json
  def new
    @parent = Parent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parent }
    end
  end

  # GET /parents/1/edit
  def edit
    @parent = Parent.find(params[:id])
  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(params[:parent])

    respond_to do |format|
      if @parent.save
        format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
        format.json { render json: @parent, status: :created, location: @parent }
      else
        format.html { render action: "new" }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parents/1
  # PUT /parents/1.json
  def update
    @parent = Parent.find(params[:id])

    respond_to do |format|
      if @parent.update_attributes(params[:parent])
        format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  def destroy
    @parent = Parent.find(params[:id])
    @parent.destroy

    respond_to do |format|
      format.html { redirect_to parents_url }
      format.json { head :no_content }
    end
  end
end
