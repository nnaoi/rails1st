class SchedulesController < ApplicationController
  before_action :authenticate_user, {only: [:top, :new, :create, :show, :edit, :update, :destroy]}
  before_action :authenticate_join, {only: [:top, :new, :create, :show, :edit, :update, :destroy]}
  
  def top
    if params[:year] && params[:month] && params[:day]
      @time = Time.zone.local(params[:year], params[:month], params[:day])
    else
      @time = Time.current
    end
    @weekSchedules = []
    (0..6).each do |scheduleNumber|
      @weekSchedules.push(
        Schedule.where(
          start_time: Time.zone.local(@time.since(scheduleNumber.days).year, @time.since(scheduleNumber.days).month, @time.since(scheduleNumber.days).day,0,0)..Time.new(@time.since(scheduleNumber.days).year, @time.since(scheduleNumber.days).month, @time.since(scheduleNumber.days).day, 23, 59)
        ).order(:start_time)
      )
    end
  end
  
  def new
    @schedule = Schedule.new
    @join_member_ids = []
  end
  
  def create
    start_time = Time.zone.parse(params[:datetime])
    tmp = Time.zone.parse(params[:end_time])
    end_time = Time.zone.local(start_time.year ,start_time.month ,start_time.day ,tmp.strftime("%H") ,tmp.strftime("%M"))
    @schedule = Schedule.new(start_time: start_time ,end_time: end_time ,title: params[:title], abs: params[:abs])
    @join_member_ids = params[:join_member_ids]
    if @join_member_ids && @schedule.save
      @join_member_ids.each do |join_member_id|
        @schedule_member = ScheduleMember.new(schedule_id: @schedule.id, user_id: join_member_id)
        @schedule_member.save
      end
      redirect_to("/schedules/top")
    else
      unless @join_member_ids
        @schedule.errors[:base] << "参加メンバーをチェックしてください。"
      end
      render("schedules/new")
    end
  end
  
  def show
    @schedule = Schedule.find_by(id: params[:id])
  end
  
  def edit
    @schedule = Schedule.find_by(id: params[:id])
  end
  
  def update
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.title = params[:title]
    @schedule.start_time = Time.zone.parse(params[:start_time])
    tmp = Time.zone.parse(params[:end_time])
    @schedule.end_time = Time.zone.local(@schedule.start_time.year ,@schedule.start_time.month ,@schedule.start_time.day ,tmp.strftime("%H") ,tmp.strftime("%M"))
    @schedule.abs = params[:abs]
    before_schedule_members = ScheduleMember.where(schedule_id: @schedule.id)
    @after_schedule_member_ids = params[:join_member_ids]
    if @after_schedule_member_ids && @schedule.save
      before_schedule_members.each do |schedule_member|
        schedule_member.destroy
      end
      @after_schedule_member_ids.each do |user_id|
        @schedule_member = ScheduleMember.new(user_id: user_id, schedule_id: @schedule.id)
        @schedule_member.save
      end
      redirect_to("/schedules/top")
    else
      unless @after_schedule_member_ids
        @schedule.errors[:base] << "参加メンバーをチェックしてください。"
      end
      render("schedules/edit")
    end
  end
  
  def destroy
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.destroy
    redirect_to("/schedules/top")
    flash[:notice] = "予定を削除しました。"
  end
  
  def update_error
  end
end
