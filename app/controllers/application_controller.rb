class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Language
  include Pagy::Backend
  include Error

  

  # # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  # around_action :switch_locale
  

  # def switch_locale(&action)
  #   I18n.with_locale(locale_from_header, &action)
  # end

  # private

  # def locale_from_header

  #   request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  # end

  

  
end
