class EstoquesController < ApplicationController
  # GET /estoques
  # GET /estoques.json
  def index
    @estoques = Estoque.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @estoques }
    end
  end

  # GET /estoques/1
  # GET /estoques/1.json
  def show
    @estoque = Estoque.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @estoque }
    end
  end

  # GET /estoques/new
  # GET /estoques/new.json
  def new
    @estoque = Estoque.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @estoque }
    end
  end

  # GET /estoques/1/edit
  def edit
    @estoque = Estoque.find(params[:id])
  end

  # POST /estoques
  # POST /estoques.json
  def create
    @estoque = Estoque.new(params[:estoque])

    respond_to do |format|
      if @estoque.save
        format.html { redirect_to action: 'index', notice: 'Estoque was successfully created.' }
        format.json { render json: @estoque, status: :created, location: @estoque }
      else
        format.html { render action: "new" }
        format.json { render json: @estoque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /estoques/1
  # PUT /estoques/1.json
  def update
    @estoque = Estoque.find(params[:id])

    respond_to do |format|
      if @estoque.update_attributes(params[:estoque])
        format.html { redirect_to action: 'index', notice: 'Estoque was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @estoque.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estoques/1
  # DELETE /estoques/1.json
  def destroy
    @estoque = Estoque.find(params[:id])
    @estoque.destroy

    respond_to do |format|
      format.html { redirect_to estoques_url }
      format.json { head :no_content }
    end
  end
end
