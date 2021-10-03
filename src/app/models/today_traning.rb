class TodayTraning < ApplicationRecord
    belongs_to :user
    
    validates :traning_weight, presence: true, on: :update
    validates :traning_reps, presence: true, on: :update
    validates :traning_note, presence: true, on: :update
    
    validates :traningevent_id, presence: true, on: :update
    
end
