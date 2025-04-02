class BasePolicy
    #para leer la variable
    attr_reader :record

    #para que lance acceso no permitido cuando se accede a cualquier método que no existe
    def initialize(record)
        @record = record
    end

    #para que lance acceso no permitido cuando se accede a cualquier método que no existe
    def method_missing(method, *args, &block)
        false
    end
end