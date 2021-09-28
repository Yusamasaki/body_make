class TodayTraning < ApplicationRecord
    belongs_to :user
    
    validates :start_time, presence: true
    validates :traning_name, presence: true, on: :update
    validates :sub_body_part, presence: true, on: :update
    validates :body_part, presence: true, on: :update
    validates :traning_weight, presence: true, on: :update
    validates :traning_reps, presence: true, on: :update
    validates :traning_note, presence: true, on: :update
    
end
