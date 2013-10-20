class CategoriaController < ApplicationController
  # GET /categoria
  # GET /categoria.json
  def index
    @categoria = Categoria.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categoria }
    end
  end

  # GET /categoria/1
  # GET /categoria/1.json
  def show
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @categoria }
    end
  end

  # GET /categoria/new
  # GET /categoria/new.json
  def new
    @categoria = Categoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @categoria }
    end
  end

  # GET /categoria/1/edit
  def edit
    @categoria = Categoria.find(params[:id])
  end

  # POST /categoria
  # POST /categoria.json
  def create
    @categoria = Categoria.new(params[:categoria])

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to action: 'index', notice: 'Categoria was successfully created.' }
        format.json { render json: @categoria, status: :created, location: @categoria }
      else
        format.html { render action: "new" }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categoria/1
  # PUT /categoria/1.json
  def update
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
      if @categoria.update_attributes(params[:categoria])
        format.html { redirect_to action: 'index', notice: 'Categoria was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoria/1
  # DELETE /categoria/1.json
  def destroy
    @categoria = Categoria.find(params[:id])
    @categoria.destroy

    respond_to do |format|
      format.html { redirect_to categoria_index_url }
      format.json { head :no_content }
    end
  end
end
