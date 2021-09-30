class TodayTraning < ApplicationRecord
    belongs_to :user
    belongs_to :traningevent

    
    validates :traning_weight, presence: true, on: :update
    validates :traning_reps, presence: true, on: :update
    validates :traning_note, presence: true, on: :update
    
end
