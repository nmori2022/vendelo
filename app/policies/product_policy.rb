class ProductPolicy < BasePolicy

    def edit
        #si es un producto y el usuario dueño del producto es el mismo usuario logeado
        #record.user_id  == Current.user.id
        record.owner?
    end

    def update
        #si es un producto y el usuario dueño del producto es el mismo usuario logeado
        record.owner?
    end

    def destroy
        #si es un producto y el usuario dueño del producto es el mismo usuario logeado
        record.owner?
    end
end
