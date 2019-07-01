class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :logout]}
  before_action :forbid_login_user, {only: [:new, :create, :signin_form, :signin]}
  
  def index
     @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    @user.save
    session[:user_id] = @user.id
    redirect_to("/settings/group")
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
  
  def signin_form
    
  end
  
  def signin
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/schedules/top")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/signin_form")
    end
  end
end
