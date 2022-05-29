class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    #pp @product

    if @product.save
      #redirect_to products_path
      #notice se metera en una variable llamada flash para estar disponible en la vista del path
      redirect_to products_path, notice: "Tu producto se ha creado correctamente"
    else
      #si no se salva, regresamos a la vista new con un status 422
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path, notice: "Tu producto se ha actualizado"
    else
      render :edit, status: :unprocessable_entity #422
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    #Por default rails manda un codigo 302, sobreescribimos con 303, indica redirect y no enlaza al producto eliminado
    redirect_to products_path, notice: "Tu producto se ha eliminado correctamente", status: :see_other #303
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end
end