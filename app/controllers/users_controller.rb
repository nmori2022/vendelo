class UsersController < ApplicationController
    skip_before_action :protect_pages, only: :show


    def show
        #el signo de exclamación es para que si no encuentra al usuario, entonces se lance una excepción
        @user = User.find_by!(username: params[:username])

        @pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }).load_async, items: 12)
    end

end