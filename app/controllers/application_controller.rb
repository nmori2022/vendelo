class ApplicationController < ActionController::Base
  include Pagy::Backend

  class NotAutorizedError < StandardError
  end

  rescue_from NotAutorizedError do
    redirect_to products_path, alert: t('common.not_autorized')
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale
  before_action :set_current_user
  before_action :protect_pages

  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

  def locale_from_header

    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to new_session_path, alert: t('common.not_logged_id') unless Current.user
  end

  def autorize!(record = nil)

    is_allowed = if record
      #si es un producto y el usuario dueño del producto es el mismo usuario logeado
      record.user_id  == Current.user.id
    else
      #si es un suaurio administrador
      Current.user.admin?
    end

    
    # se lanza un error cuando no está autorizado y luego el error se captura más arriba en rescue_from NotAutorizedError
    #donde se redirige a la página de productos


    raise NotAutorizedError unless is_allowed
 
  end
end
