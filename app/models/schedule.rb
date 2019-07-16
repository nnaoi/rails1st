class Schedule < ApplicationRecord
    validates :start_time, {presence: true}
    validates :end_time, {presence: true}
    validate :start_end_check
    
    def start_end_check
      unless self.start_time <= self.end_time
        errors.add(:end_date, "の日付を正しく記入してください。")
      end
    end
end
