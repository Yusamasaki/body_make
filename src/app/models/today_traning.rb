class TodayTraning < ApplicationRecord
    belongs_to :user
    belongs_to :traningevent
    belongs_to :bodypart
    
    validates :traning_weight, presence: true, on: :update
    validates :traning_reps, presence: true, on: :update
    validates :traning_note, presence: true, on: :update
    
end
