
class HomeController < ApplicationController
  before_action :forbid_login_user, {only: [:top, :about]}
  
  def top
  end
  
  def about
    @time = Time.current
    @schedules = Schedule.where(start_time: Time.new(@time.year, @time.month, @time.day,0,0)..Time.new(@time.year, @time.month, @time.day, 23, 59))
  end
end
