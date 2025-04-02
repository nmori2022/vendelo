module Authorization
    extend ActiveSupport::Concern

    included do
        class NotAuthorizedError < StandardError; end

        rescue_from NotAuthorizedError do
            redirect_to products_path, alert: t('common.not_authorized')
        end

        private
        def authorize!(record = nil)

            is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)

            # se lanza un error cuando no está autorizado y luego el error se captura más arriba en rescue_from NotAuthorizedError
            #donde se redirige a la página de productos

            raise NotAuthorizedError unless is_allowed
        end
    end
end