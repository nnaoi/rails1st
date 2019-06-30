class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    if @current_user
      @current_belongto = BelongTo.find_by(user_id: @current_user.id)
    end
    if @current_belongto
      @current_group = Group.find_by(id: @current_belongto.group_id)
      @belongtos = BelongTo.where(group_id: @current_belongto.group_id)
      @group_users = User.where(id: @belongtos.pluck("user_id"))
    end
  end
  
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/signin")
    end
  end
  
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/schedules/top")
    end
  end
  
  def authenticate_join
    if !@current_belongto
      redirect_to("/settings/group")
    end
  end
  
  def hello
    render html: "hello, world!"
  end
end
