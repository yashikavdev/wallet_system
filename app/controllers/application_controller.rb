class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    return if current_user

    render json: { error: 'You must be signed in to access this resource' }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
