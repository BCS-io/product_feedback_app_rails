class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  after_action :verify_authorized, unless: :devise_controller?

  helper_method :retrieve_last_index_page_or_default

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[first_name last_name avatar username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def store_last_index_page
    session[:last_index_page] = request.fullpath
  end

  def retrieve_last_index_page_or_default(default_path: root_path)
    session[:last_index_page] || default_path
  end

  def store_back_location!
    session[:return_to] = request.referer
  end

  def retrieve_back_location_or_default(default_path: root_path)
    session.delete(:return_to) || default_path
  end

  private

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
