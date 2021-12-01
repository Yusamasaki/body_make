class User < ApplicationRecord
  # create前にset_idメソッドを呼び出す
  before_create :set_id

  has_many :bodyweights, dependent: :destroy

  has_many :myfoods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :recipefoods, dependent: :destroy
  has_many :todaymeals, dependent: :destroy
  has_many :todaymeal_recipes, dependent: :destroy
  has_many :meals_analysis, dependent: :destroy
  
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
  
  private
    def set_id
      # id未設定、または、すでに同じidのレコードが存在する場合はループに入る
      while self.id.blank? || User.find_by(id: self.id).present? do
        # ランダムな20文字をidに設定し、whileの条件検証に戻る
        self.id = SecureRandom.alphanumeric(20)
      end
    end

end
