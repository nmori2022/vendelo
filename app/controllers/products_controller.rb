class ProductsController < ApplicationController

    skip_before_action :protect_pages, only: [:index, :show]

    def index
        @categories = Category.order(name: :asc).load_async
        #@products = Product.all.with_attached_photo
        #if params[:category_id]
        #    @products = @products.where(category_id: params[:category_id])
        #end
        #if params[:min_price].present?
        #    @products = @products.where('price >= ?', params[:min_price])
        #end
        #if params[:max_price].present?
        #    @products = @products.where('price <= ?', params[:max_price])
        #end
        #if params[:query_text].present?
        #    @products = @products.search_full_text(params[:query_text])
        #end
        #
        #order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
        #@products = @products.order(order_by).load_async
        #@products = @products.order(order_by).load_async



        #@pagy, @products = pagy_countless(@products, items: 12)
        @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
    end
    def show
       #@product = Product.find(params[:id])
       product
    end

    def new
        @product = Product.new
    end

    def create
        #@product = Product.new(product_params)
        #@product = Current.user.products.new(product_params)
        @product = Product.new(product_params)

        
        if @product.save
            redirect_to products_path, notice: t('.created')
        else
            render :new, status: :unprocessable_entity
        end
        #pp @product
    end

    def edit
        authorize! product
        #@product = Product.find(params[:id])
        #product
    end

    def update
        authorize! product
        #@product = Product.find(params[:id])
        if product.update(product_params)
            redirect_to products_path, notice: t('.updated')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        authorize! product
        #@product = Product.find(params[:id])
        #@product.destroy
        product.destroy

        redirect_to products_path, notice: t('.destroyed'), status: :see_other
    end

     private
        def product_params
            params.require(:product).permit(:title, :description, :price, :photo, :category_id)
        end
        def product_params_index
            params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites, :user_id)
        end

    def product
        @product ||= Product.find(params[:id])
    end
end