class BelongTo < ApplicationRecord
  validates :user_id, {uniqueness: true}
end
