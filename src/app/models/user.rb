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

  validates :username, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  private
  # SNS 認証
  def self.find_oauth(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.create(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        username: auth.info.name,
        password: Devise.friendly_token[0,20]
      )
    end
    return {user: user}
  end
end
