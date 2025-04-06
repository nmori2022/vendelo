class FavoritesController < ApplicationController
    def create
        #product.favorites.create(user: Current.user)
        product.favorite!
        redirect_to product_path(product)
    end

    def destroy
        #product.favorites.find_by(user: Current.user).destroy
        product.unfavorite!
        redirect_to product_path(product), status: :see_other
    end
    
    private
    
    def product
        # ||= is a shortcut for ||= Product.find(params[:product_id])
        # permite memorizar el producto para que no se realicen 2 veces la consulta a la BD del mismo producto
        # se denomina MEMORIZATION
        @product ||=Product.find(params[:product_id])
    end

end