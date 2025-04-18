class FavoritesController < ApplicationController

    def index
        
    end

    def create
        #product.favorites.create(user: Current.user)
        product.favorite!
        respond_to do |format|
            format.html do
                redirect_to product_path(product)
            end
            format.turbo_stream do
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product})
            end
        end
    end

    def destroy
        #product.favorites.find_by(user: Current.user).destroy
        product.unfavorite!
        respond_to do |format|
            format.html do
                redirect_to product_path(product), status: :see_other
            end
            format.turbo_stream do
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product})
            end
        end
    end
    
    private
    
    def product
        # ||= is a shortcut for ||= Product.find(params[:product_id])
        # permite memorizar el producto para que no se realicen 2 veces la consulta a la BD del mismo producto
        # se denomina MEMORIZATION
        @product ||=Product.find(params[:product_id])
    end

end