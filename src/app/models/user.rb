class User < ApplicationRecord

  has_many :bodyweights, dependent: :destroy

  has_many :myfoods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipefoods, dependent: :destroy
  has_many :today_meals, dependent: :destroy
  
  has_many :traningevents, dependent: :destroy
  has_many :today_tranings, dependent: :destroy
  has_many :traning_analysis, dependent: :destroy
  has_many :today_exercise, dependent: :destroy

  has_one :targetweight, dependent: :destroy
  has_one :bmr, dependent: :destroy
  has_one :pfc_ratio, dependent: :destroy

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         

end
