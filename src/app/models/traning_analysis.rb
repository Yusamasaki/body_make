class TraningAnalysis < ApplicationRecord
  belongs_to :user
  belongs_to :traningevent
  
  validates :total_load, presence: true, on: :update
  validates :start_time, presence: true
  
end
