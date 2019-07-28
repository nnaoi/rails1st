class SettingsController < ApplicationController
  before_action :authenticate_user, {only: [:group, :group_new, :add_self_to_group, :remove_self_group]}
  
  # グループ設定
  def group
  end
  
  # グループ新規作成
  def group_new
    @group = Group.new(name: params[:group_name])
    if @group.save
      flash[:primary] = "グループを追加しました"
      redirect_to("/settings/group")
    else
      flash[:danger] = "同名グループが存在しています。または、グループ名を空にすることはできません。"
      redirect_to("/settings/group")
    end
  end
  
  # グループに自分を追加
  def add_self_to_group
    @group = Group.find_by(name: params[:group_name])
    if @group
      @belongto = BelongTo.new(group_id: @group.id, user_id:@current_user.id)
      if @belongto.save
        flash[:primary] = "グループに追加しました"
        redirect_to("/settings/group")
      else
        flash[:danger] = "既にグループ名は追加されています"
        redirect_to("/settings/group")
      end
    else
      flash[:danger] = "グループが存在しません。「グループ追加」からグループを追加してください。"
      redirect_to("/settings/group")
    end
  end
  
  # グループを抜ける
  def remove_self_group
    @belongto = BelongTo.find_by(user_id: @current_user.id)
    @belongto.destroy
    @scheduleMembers = ScheduleMember.where(user_id: @current_user.id)
    @scheduleMembers.each do |scheduleMember|
      scheduleMember.destroy
      unless ScheduleMember.where(schedule_id: scheduleMember.schedule_id)
        schedule = Schedule.find_by(id: scheduleMember.schedule_id)
        schedule.destroy
      end
    end
    redirect_to("/settings/group")
    flash[:primary] = "グループを抜けました。"
  end
end
