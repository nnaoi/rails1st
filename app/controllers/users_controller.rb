class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :logout]}
  before_action :forbid_login_user, {only: [:new, :create, :signin_form, :signin]}
  
  def index
     @users = User.all
  end
  
  # ユーザ新規作成
  def new
    @user = User.new(session[:user] || {})
  end
  
  # ユーザ新規作成
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      session[:user] = nil
      redirect_to("/settings/group")
    else
      session[:user] = @user.attributes.slice(*params.keys)
      flash[:danger] = @user.errors.full_messages
      redirect_to("/signup")
    end
  end
  
  # バリデーションエラー→getリクエスト対応
  def create_refresh
    redirect_to("/signup")
  end
  
  def logout
    session[:user_id] = nil
    flash[:primary] = "ログアウトしました"
    redirect_to("/")
  end
  
  def signin_form
    @user = User.new(session[:user] || {})
  end
  
  def signin
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:user] = nil
      flash[:primary] = "ログインしました"
      redirect_to("/schedules/top")
    else
      @user = User.new(email: params[:email])
      flash[:danger] = "メールアドレスまたはパスワードが間違っています"
      session[:user] = @user.attributes.slice(*params.keys)
      redirect_to("/signin")
    end
  end
end
