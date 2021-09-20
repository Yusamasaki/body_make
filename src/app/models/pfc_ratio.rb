class PfcRatio < ApplicationRecord

  belongs_to :user

  validates :protein, presence: true
  validates :fat, presence: true
  validates :carbo, presence: true

end
