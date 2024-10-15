class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(name: params[:name])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        message: 'Logged in successfully',
        user:
      }, status: :ok
    else
      render json: {
        message: 'Invalid credentials'
      }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {
      message: 'Logged out successfully'
    }, status: :ok
  end
end
