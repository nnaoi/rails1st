class SchedulesController < ApplicationController
  before_action :authenticate_user, {only: [:top, :new, :create, :show, :edit, :update, :date_update, :destroy]}
  before_action :authenticate_join, {only: [:top, :new, :create, :show, :edit, :update, :date_update, :destroy]}
  
  def top
    @time = Time.current
    @schedules = Schedule.where(start_time: Time.new(@time.year, @time.month, @time.day,0,0)..Time.new(@time.year, @time.month, @time.day, 23, 59))
    @schedules2 = Schedule.where(start_time: Time.new(@time.tomorrow.year, @time.tomorrow.month, @time.tomorrow.day,0,0)..Time.new(@time.tomorrow.year, @time.tomorrow.month, @time.tomorrow.day, 23, 59))
    @schedules3 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.day, 23, 59))
    @schedules4 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.day, 23, 59))
    @schedules5 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.day, 23, 59))
    @schedules6 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day, 23, 59))
    @schedules7 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day, 23, 59))
  end
  
  def new
    
  end
  
  def create
    @schedule = Schedule.new(start_time: Time.zone.parse(params[:datetime]) , title: params[:title], abs: params[:abs])
    @schedule.save
    params[:join_member_ids].each do |join_member_id|
      @schedule_member = ScheduleMember.new(schedule_id: @schedule.id, user_id: join_member_id)
      @schedule_member.save
    end
    redirect_to("/schedules/top")
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
    @schedule.start_time = params[:start_time]
    @schedule.abs = params[:abs]
    @schedule.save
    before_schedule_members = ScheduleMember.where(schedule_id: @schedule.id)
    after_schedule_member_ids = params[:join_member_ids]
    before_schedule_members.each do |schedule_member|
      schedule_member.destroy
    end
    after_schedule_member_ids.each do |user_id|
      @schedule_member = ScheduleMember.new(user_id: user_id, schedule_id: @schedule.id)
      @schedule_member.save
    end
    redirect_to("/schedules/top")
  end
  
  def date_update
    @time = Time.zone.local(params[:year], params[:month], params[:day])
    @schedules = Schedule.where(start_time: Time.new(@time.year, @time.month, @time.day,0,0)..Time.new(@time.year, @time.month, @time.day, 23, 59))
    @schedules2 = Schedule.where(start_time: Time.new(@time.tomorrow.year, @time.tomorrow.month, @time.tomorrow.day,0,0)..Time.new(@time.tomorrow.year, @time.tomorrow.month, @time.tomorrow.day, 23, 59))
    @schedules3 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.day, 23, 59))
    @schedules4 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.day, 23, 59))
    @schedules5 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.day, 23, 59))
    @schedules6 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day, 23, 59))
    @schedules7 = Schedule.where(start_time: Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day,0,0)..Time.new(@time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.year, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.month, @time.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow.day, 23, 59))
    render("schedules/top")
  end
  
  def destroy
    @schedule = Schedule.find_by(id: params[:id])
    @schedule.destroy
    redirect_to("/schedules/top")
    flash[:notice] = "予定を削除しました。"
  end
end