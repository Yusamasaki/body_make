class PfcRatio < ApplicationRecord

  belongs_to :user

  validates :protein, presence: true
  validates :fat, presence: true
  validates :carbo, presence: true
  
  validate :protein_fat_carbo_total_100_percentage
  
  def protein_fat_carbo_total_100_percentage
    if protein && fat && carbo
      errors.add(:protein, "合計を100％にする必要があります。") unless (protein + fat + carbo) == 100
    end
  end
  
  def self.pfc_format(one_day_decrease, ratio, per_1g)
    ( ( ( one_day_decrease * ratio ) / 100 ) / per_1g ).floor(1)
  end
end
