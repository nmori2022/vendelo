class FavoritesController < ApplicationController
    def create
        Favorite.create(product: product, user: Current.user)
        redirect_to product_path(product)
    end
    
    private
    
    def product
        # ||= is a shortcut for ||= Product.find(params[:product_id])
        # permite memorizar el producto para que no se realicen 2 veces la consulta a la BD del mismo producto
        # se denomina MEMORIZATION
        @product ||=Product.find(params[:product_id])
    end

end