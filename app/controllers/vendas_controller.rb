class VendasController < ApplicationController

  # GET /vendas
  # GET /vendas.json
  include ActionView::Helpers::NumberHelper

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

    @categorias = Categoria.all

    unless params[:op].blank?
      unless params[:op] != 'cart'

        if @cart[@produtoId].blank?
          @cart[@produtoId] = 1
        else
          @cart[@produtoId] = session[:cart][@produtoId] + 1
        end

      end

      unless params[:op] != 'cartmenos'

        if @cart[@produtoId].blank?
          @cart[@produtoId] = 1
        else
          @cart[@produtoId] = session[:cart][@produtoId] - 1
          @cart.delete_if{|key,value| value == 0}
        end

      end

      unless params[:op] != 'finalizar'


        File.open("public/cupom.txt", "a+") do |f|

          d = DateTime.now
          t = Time.now
          data = d.strftime(fmt='%F')
          hora = t.strftime("%H:%M:%S")

          f.print "-----------------------------------------".center(40) + "\n"
          f.print "CNEC - Esc. Cenecista Joāo R. Amorim".center(40) + "\n"
          f.print "-----------------------------------------".center(40) + "\n\n"
          f.print "Data: #{data}".ljust(9)
          f.print "Hora: #{hora}".rjust(25) + "\n\n"
          f.print "-----------------------------------------".center(40) + "\n"
          f.print "CUPOM SEM VALOR FISCAL".center(40) + "\n"
          f.print "-----------------------------------------".center(40) + "\n\n"

          cabecalho = "Produto" + "         " + "Preço" + "    " + "Qtd" + "    " + "Sub-Total" + "\n"

          f << cabecalho

          @prodCart.each do |p|

            preco_venda = p.preco_venda.to_s
            

            subtotal = number_to_currency(session[:cart][p.id.to_s].to_i * p.preco_venda, :unit => "R$")
            f.print p.nome.ljust(16).first(16)
            f.print number_to_currency(p.preco_venda, :unit => "").rjust(5)
            f.print session[:cart][p.id.to_s].to_s.rjust(7)
            f.print subtotal.to_s.rjust(13) + "\n"
          end

          f.print "\n"

          f.print "-----------------------------------------".center(40) + "\n"
          f.print "Total:".ljust(6)
          f.print number_to_currency(@totalCart, :unit => "R$").rjust(35) + "\n"
          f.print "-----------------------------------------".center(40) + "\n\n"
          f.print "-----------------------------------------".center(40) + "\n"
          f.print "ESTE DOCUMENTO NÃO TEM VALOR FISCAL".center(40) + "\n"
          f.print "-----------------------------------------".center(40) + "\n\n"
          f.print "Desenvolvido pela Logon Informatica".center(40) + "\n"
          f.print "www.logon.inf.br".center(40) + "\n\n"
          f.print "-----------------------------------------".center(40) + "\n\n"



        end





        @consumidor = Consumidor.find(params[:consumidor])

        @prodCart.each do |p|
          venda = Venda.new
          venda.produto = p
          venda.quantidade_venda = @cart[p.id.to_s].to_i
          venda.consumidor = @consumidor
          venda.valor_total = venda.quantidade_venda * p.preco_venda

          venda.save

          @estoque = p.estoque
          @quantidade_final = @estoque.quantidade_estoque - venda.quantidade_venda

          @venda = venda


        end

        
        case @consumidor.operacao
          when "pre" 
            if @consumidor.saldo > @venda.valor_total
              then
                @consumidor.saldo -= @venda.valor_total
                @estoque.update_attributes(:quantidade_estoque => @quantidade_final, :produto_id => @estoque.produto_id)
            else
              respond_to do |format|
                format.html { redirect_to :back, notice: 'Saldo Insuficiente' }
              end
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

      #system('php /Volumes/BACKUP/projetos/cantina-escolar/public/phpinfo.php')
      session[:cart] = {}

      end

      return redirect_to :back
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
