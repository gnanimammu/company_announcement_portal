class UsersController < ApplicationController
  before_action :set_user, :require_login, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def index
	  if params[:search].present?
      @users = User.where('username LIKE ?', "%#{params[:search]}%")
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path(@user), notice: 'Welcome to the app!'
    else
      render :new
    end
  end

  def show
     @user = User.find_by(id: params[:id])
      if @user.nil?
       # If user is not found, redirect or render a 404 page
       redirect_to root_path, notice: 'User not found'
      end
  end
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

   def authorize_user
    # Assuming you want to allow users to edit only their own profiles
    unless current_user == @user
      redirect_to users_path, alert: 'You are not authorized to edit this profile.'
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone_number, :address, :job_title)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
