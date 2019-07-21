class Schedule < ApplicationRecord
    validates :start_time, {presence: true}
    validates :end_time, {presence: true}
    validates :title, {presence: true}
    validate :start_end_check
    
    def start_end_check
      unless self.start_time <= self.end_time
        errors[:base] << "終了時刻が不正です。"
      end
    end
end
