class ConsumidorsController < ApplicationController
  # GET /consumidors
  # GET /consumidors.json
  def index
    @consumidors = Consumidor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @consumidors }
    end
  end

  # GET /consumidors/1
  # GET /consumidors/1.json
  def show
    @consumidor = Consumidor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @consumidor }
    end
  end

  # GET /consumidors/new
  # GET /consumidors/new.json
  def new
    @consumidor = Consumidor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @consumidor }
    end
  end

  # GET /consumidors/1/edit
  def edit
    @consumidor = Consumidor.find(params[:id])
  end

  # POST /consumidors
  # POST /consumidors.json
  def create
    @consumidor = Consumidor.new(params[:consumidor])

    respond_to do |format|
      if @consumidor.save
        format.html { redirect_to @consumidor, notice: 'Consumidor was successfully created.' }
        format.json { render json: @consumidor, status: :created, location: @consumidor }
      else
        format.html { render action: "new" }
        format.json { render json: @consumidor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /consumidors/1
  # PUT /consumidors/1.json
  def update
    @consumidor = Consumidor.find(params[:id])

    respond_to do |format|
      if @consumidor.update_attributes(params[:consumidor])
        format.html { redirect_to @consumidor, notice: 'Consumidor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @consumidor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumidors/1
  # DELETE /consumidors/1.json
  def destroy
    @consumidor = Consumidor.find(params[:id])
    @consumidor.destroy

    respond_to do |format|
      format.html { redirect_to consumidors_url }
      format.json { head :no_content }
    end
  end
end
