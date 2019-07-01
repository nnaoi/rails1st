class SettingsController < ApplicationController
  def group
  end
  
  def group_new
    @group = Group.new(name: params[:group_name])
    if @group.save
      flash[:notice] = "グループを追加しました"
      redirect_to("/settings/group")
    else
      flash[:notice] = "既にそのグループ名は作成されています"
      render("/settings/group")
    end
  end
  
  def add_self_to_group
    @belongto = BelongTo.new(group_id: Group.find_by(name: params[:group_name]).id, user_id:@current_user.id)
    if @belongto.save
      flash[:notice] = "グループに追加しました"
      redirect_to("/settings/group")
    else
      flash[:notice] = "既にグループ名は追加されています"
      render("/settings/group")
    end
  end
  
  def remove_self_group
    @belongto = BelongTo.find_by(user_id: @current_user.id)
    @belongto.destroy
    redirect_to("/settings/group")
    flash[:notice] = "グループを抜けました。"
  end
end
