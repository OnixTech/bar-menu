class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_locale

  include Pundit::Authorization

  after_action :verify_authorized, except: %i[index show], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def after_sign_in_path_for(_user)
    companies_path
  end

  def after_sign_up_path_for(_user)
    companies_path
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
      parsed_locale.to_sym :
      nil
  end
end
