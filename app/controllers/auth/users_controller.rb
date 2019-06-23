class Auth::UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    if user_signed_in?
      user = current_user
      render json: { status: 'SUCCESS', message: 'the user is loaded', data: user }
    else
      render json: { status: 'ERROR', message: 'the user is not loaded', data: user.errors }
    end
  end
end
