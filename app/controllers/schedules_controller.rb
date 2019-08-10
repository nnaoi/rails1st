class SchedulesController < ApplicationController
  before_action :authenticate_user, {only: [:top, :new, :create, :show, :edit, :update, :destroy]}
  before_action :authenticate_join, {only: [:top, :new, :create, :show, :edit, :update, :destroy]}
  
  # スケジュール一覧取得
  def top
    session[:schedule] = nil
    session[:schedule_member_ids] = nil
    if params[:year] && params[:month] && params[:day]
      @time = Time.zone.local(params[:year], params[:month], params[:day])
    else
      @time = Time.current
    end
    @weekSchedules = []
    # スケジュールを何日分表示するか。 ex.) 10日分:(0..9)
    displayed_number = (0..6)
    displayed_number.each do |scheduleNumber|
      @weekSchedules.push(
        Schedule.where(
          start_time: Time.zone.local(@time.since(scheduleNumber.days).year, @time.since(scheduleNumber.days).month, @time.since(scheduleNumber.days).day,0,0)..Time.new(@time.since(scheduleNumber.days).year, @time.since(scheduleNumber.days).month, @time.since(scheduleNumber.days).day, 23, 59)
        ).order(:start_time)
      )
    end
  end
  
  # スケジュール新規作成
  def new
    @schedule = Schedule.new(session[:schedule] || {})
    @schedule_member_ids = session[:schedule_member_ids] || [] 
  end
  
  # スケジュール新規作成
  def create
    # Scheduleモデルに関する処理
    start_time = Time.zone.parse(params[:start_time])
    tmp = Time.zone.parse(params[:end_time])
    end_time = Time.zone.local(start_time.year ,start_time.month ,start_time.day ,tmp.strftime("%H") ,tmp.strftime("%M"))
    @schedule = Schedule.new(start_time: start_time ,end_time: end_time ,title: params[:title], abs: params[:abs])
    @schedule_member_ids = params[:schedule_member_ids]
    
    # ScheeduleMemberモデルに関する処理
    if @schedule.save && @schedule_member_ids
      @schedule_member_ids.each do |schedule_member_id|
        @schedule_member = ScheduleMember.new(schedule_id: @schedule.id, user_id: schedule_member_id)
        @schedule_member.save
      end
      session[:schedule] = nil
      session[:schedule_member_ids] = nil
      redirect_to("/schedules/top")
    else
      session[:schedule] = @schedule.attributes.slice(*params.keys)
      session[:schedule_member_ids] = @schedule_member_ids
      unless @schedule_member_ids
        @schedule.errors[:base] << ("参加メンバーをチェックしてください。")
      end
      flash[:danger] = @schedule.errors.full_messages
      redirect_to("/schedules/new")
    end
  end
  
  # スケジュール詳細を表示
  def show
    @schedule = Schedule.find_by(id: params[:id])
  end
  
  # スケジュールを編集
  def edit
    @schedule = Schedule.find_by(id: params[:id])
    @schedule_member_ids = ScheduleMember.where(schedule_id: @schedule.id).pluck("user_id")
    if session[:schedule]
      session[:schedule].each do |key, value|
        @schedule.send("#{key}=", value)
      end
    end
    if session[:schedule_member_ids]
      @schedule_member_ids =  session[:schedule_member_ids].map!(&:to_i)
    end
  end
  
  # スケジュールを編集
  def update
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.title = params[:title]
    @schedule.start_time = Time.zone.parse(params[:start_time])
    tmp = Time.zone.parse(params[:end_time])
    @schedule.end_time = Time.zone.local(@schedule.start_time.year ,@schedule.start_time.month ,@schedule.start_time.day ,tmp.strftime("%H") ,tmp.strftime("%M"))
    @schedule.abs = params[:abs]
    before_schedule_members = ScheduleMember.where(schedule_id: @schedule.id)
    @after_schedule_member_ids = params[:schedule_member_ids]
    if @schedule.save && @after_schedule_member_ids
      before_schedule_members.each do |schedule_member|
        schedule_member.destroy
      end
      @after_schedule_member_ids.each do |user_id|
        @schedule_member = ScheduleMember.new(user_id: user_id, schedule_id: @schedule.id)
        @schedule_member.save
      end
      session[:schedule] = nil
      session[:schedule_member_ids] = nil
      redirect_to("/schedules/top")
    else
      session[:schedule] = @schedule.attributes.slice(*params.keys)
      session[:schedule_member_ids] = @after_schedule_member_ids || []
      unless @after_schedule_member_ids
        @schedule.errors[:base] << "参加メンバーをチェックしてください。"
      end
      flash[:danger] = @schedule.errors.full_messages
      redirect_to("/schedules/#{@schedule.id}/edit")
    end
  end
  
  # スケジュールを削除
  def destroy
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.destroy
    redirect_to("/schedules/top")
    flash[:primary] = "予定を削除しました。"
  end
  
end
