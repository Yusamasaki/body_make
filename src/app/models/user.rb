class User < ApplicationRecord

  has_many :bodyweights, dependent: :destroy

  has_many :myfoods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipefoods, dependent: :destroy
  has_many :todaymeals, dependent: :destroy
  has_many :todaymeal_recipes, dependent: :destroy
  has_many :meals_analysis, dependent: :destroy
  has_many :sns_sredential, dependent: :destroy
  
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

    
  # SNS 認証@
   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = User.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = User.where(id: snscredential.id).first
    else
      user = User.create(
        email: auth.email,
        username: auth.username,
        uid: auth.uid,
        provider: auth.provider,
      )
    end
    return {user: user}
  end
end
