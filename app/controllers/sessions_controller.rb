class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to users_path(@user), notice: 'Logged in successfully!'
    else
      flash[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
  
  	@user = User.find_by(email: params[:email])
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully!'
  end

end
