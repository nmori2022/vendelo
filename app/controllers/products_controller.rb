class ProductsController < ApplicationController
    def index
        @products = Product.all.order(id: :asc).with_attached_photo
    end
    def show
       #@product = Product.find(params[:id])
       product
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            redirect_to products_path, notice: t('.created')
        else
            render :new, status: :unprocessable_entity
        end
        #pp @product
    end

    def edit
        #@product = Product.find(params[:id])
        product
    end

    def update
         #@product = Product.find(params[:id])
         if product.update(product_params)
            redirect_to products_path, notice: t('.updated')
         else
            render :edit, status: :unprocessable_entity
         end
    end

    def destroy
         #@product = Product.find(params[:id])
         #@product.destroy
         product.destroy

         redirect_to products_path, notice: t('.destroyed'), status: :see_other
    end

     private
        def product_params
            params.require(:product).permit(:title, :description, :price, :photo)
        end

    def product
        @product = Product.find(params[:id])
    end
end