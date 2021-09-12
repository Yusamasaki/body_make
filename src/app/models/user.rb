class User < ApplicationRecord

  has_many :bodyweights, dependent: :destroy
  has_many :myfood, dependent: :destroy
  has_many :recipe, dependent: :destroy
  has_many :recipefood, dependent: :destroy
  has_many :my_meal, dependent: :destroy
  has_one :targetweight, dependent: :destroy
  has_one :bmr, dependent: :destroy

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
         

end
