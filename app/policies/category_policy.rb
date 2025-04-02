class CategoryPolicy < BasePolicy
    
    #se sobreescribe el metodo method_missing de la clase base_policy para verificar si el usuario logeado es administrador
    # esto es llamado con cualquier método por eso se dejan en comentarios los métodos index, new, create, edit, etc
    def method_missing(method, *args, &block)
        Current.user.admin?
    end

    # def index
    #     #si es un suaurio administrador
    #     Current.user.admin?
    # end

    # def new
    #     #si es un suaurio administrador
    #     Current.user.admin?
    # end

    # def create
    #     #si es un suaurio administrador
    #     Current.user.admin?
    # end

    # def edit
    #     #si es un suaurio administrador
    #     Current.user.admin?
    # end

    # def update
    #     #si es un suaurio administrador
    #     Current.user.admin?
    # end

    # def destroy
    #     #si es un suaurio administrador
    #     Current.user.admin?
    # end

end
