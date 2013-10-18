class VendasController < ApplicationController

  # GET /vendas
  # GET /vendas.json

  layout "venda"

  before_filter :load_cart

  def load_cart
    @cart = session[:cart]
    @produtoId = params[:produto]
    @prodCart = []
    @cart.each do |key, value|
      @prodCart = Produto.where(:id => @cart.keys) 
    end
    @totalCart = 0
    @prodCart.each do |p|
      @totalCart += p.preco_venda * @cart[p.id.to_s].to_i
    end
  end

  def index
    @vendas = Venda.all

    unless params[:op].blank?
      unless params[:op] != 'cart'

        if @cart[@produtoId].blank?
          @cart[@produtoId] = 1
        else
          @cart[@produtoId] = session[:cart][@produtoId] + 1
        end

      end

      unless params[:op] != 'finalizar'
        @consumidor = Consumidor.find(params[:consumidor]);

        @prodCart.each do |p|
          venda = Venda.new
          venda.produto = p
          venda.quantidade_venda = @cart[p.id.to_s].to_i
          venda.consumidor = @consumidor
          venda.valor_total = venda.quantidade_venda * p.preco_venda

          venda.save

          @estoque = p.estoque
          @estoque.quantidade_estoque -= venda.quantidade_venda

          @venda = venda


        end

        
        case @consumidor.operacao
          when "pre" 
            if @consumidor.saldo > @venda.valor_total
              then
                @consumidor.saldo -= @venda.valor_total
                @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id)
            else
              format.html { redirect_to :back, notice: 'Saldo Insuficiente' }
            end  
          when "pos" 
            then 
             @consumidor.saldo -= @venda.valor_total
             @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id)
          when "prepos" 
            then 
             @consumidor.saldo -= @venda.valor_total
             @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id) 
        end

        @consumidor.save   

        #se consumidor for nulo a venda sera considerada avista (atualiza estoque)
        if @consumidor == nil
          @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id)
        end

      session[:cart] = {}

      end

      return redirect_to vendas_path
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vendas }
    end
  end

  # GET /vendas/1
  # GET /vendas/1.json
  def show
    @venda = Venda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @venda }
    end
  end

  # GET /vendas/new
  # GET /vendas/new.json
  def new
    @venda = Venda.new
    @produtos = Produto.mostrar_produtos

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @venda }
    end
  end

  # GET /vendas/1/edit
  def edit
    @venda = Venda.find(params[:id])
  end

  # POST /vendas
  # POST /vendas.json
  def create
    @venda = Venda.new(params[:venda])
    
    @estoque = @venda.produto.estoque
    @quantidade_final = @estoque.quantidade_estoque - @venda.quantidade_venda

    @consumidor = @venda.consumidor

    respond_to do |format|
      
      if @venda.save
        
        if @consumidor != nil
          
          case @consumidor.operacao
            when "pre" 
              if @consumidor.saldo > @venda.valor_total
                then
                  @consumidor.saldo -= @venda.valor_total
                  @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id)
              else
                format.html { redirect_to :back, notice: 'Saldo Insuficiente' }
              end  
            when "pos" 
              then 
               @consumidor.saldo -= @venda.valor_total
               @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id)
            when "prepos" 
              then 
               @consumidor.saldo -= @venda.valor_total
               @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id) 
          end

          @consumidor.save      

        end
        
        #se consumidor for nulo a venda sera considerada avista (atualiza estoque)
        if @consumidor == nil
          @estoque.update_attributes(:quantidade_estoque => @quantidade_final, 
                                     :produto_id => @estoque.produto_id)
        end


        format.html { redirect_to @venda, notice: 'Venda was successfully created.' }
        format.json { render json: @venda, status: :created, location: @venda }
      else
        format.html { render action: "new" }
        format.json { render json: @venda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vendas/1
  # PUT /vendas/1.json
  def update
    @venda = Venda.find(params[:id])   

    respond_to do |format|
      if @venda.update_attributes(params[:venda]) 
        format.html { redirect_to @venda, notice: 'Venda was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @venda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendas/1
  # DELETE /vendas/1.json
  def destroy
    @venda = Venda.find(params[:id])
    @venda.destroy

    respond_to do |format|
      format.html { redirect_to vendas_url }
      format.json { head :no_content }
    end
  end




end
