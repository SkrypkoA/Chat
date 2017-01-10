class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :trace_event, if: :user_signed_in?
  before_action :set_locale
  before_action :set_users_all

  private

    def trace_event
      Event.create!(user: current_user, details: request.url, event_type: request.method)
    end

    def set_locale
      cookies.permanent[:locale] = params[:locale].to_s if params[:locale]
      I18n.locale = cookies[:locale] || I18n.default_locale
    end

    def set_users_all
      @users_all = User.all
    end

end
