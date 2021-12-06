class Myfood < ApplicationRecord
   belongs_to :user
   has_many :todaymeals, dependent: :destroy
   has_many :recipefoods, dependent: :destroy

   validates :food_name, presence: true, length: { maximum: 100 }, uniqueness: true
   validates :calorie, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10000, message: " : Please input 0~10000"}
   validates :protein, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :fat, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :carbo, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :sugar, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :dietary_fiber, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :salt, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   
  # 検索機能
   def self.search_food(search)
      if search.present?
        Myfood.where(['food_name LIKE ?', "%#{search}%"])
      else
        Myfood.all.order(id: "DESC")
      end
   end
   
  # CSVインポート
  def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      myfood = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      myfood.attributes = row.to_hash.slice(*updatable_attributes)
      myfood.save!
    end
  end
  
  # 更新を許可するカラムを定義(CSVインポート)
  def self.updatable_attributes
    ["food_name", "calorie", "protein", "fat", "carbo", "dietary_fiber", "sugar", "salt"]
  end
end
