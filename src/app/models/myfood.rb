class Myfood < ApplicationRecord
   belongs_to :user
   has_many :todaymeals, dependent: :destroy
   has_many :recipefoods, dependent: :destroy

   validates :food_name, presence: true, length: { maximum: 100 }, uniqueness: true
   validates :calorie, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10000, message: " : 0 ~ 10000 までの数値を入力ください。"}
   validates :protein, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : 0 ~ 1000 までの数値を入力ください。"}
   validates :fat, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : 0 ~ 1000 までの数値を入力ください。"}
   validates :carbo, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : 0 ~ 1000 までの数値を入力ください。"}
   validates :sugar, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : 0 ~ 1000 までの数値を入力ください。"}
   validates :dietary_fiber, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : 0 ~ 1000 までの数値を入力ください。"}
   validates :salt, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : 0 ~ 1000 までの数値を入力ください。"}
   
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
    save_cnt = 0
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      myfood = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      myfood.attributes = row.to_hash.slice(*updatable_attributes)
      if myfood.save
        save_cnt += 1
      else
        save_cnt += 0
      end
    end
    save_cnt
  end
  
  # 更新を許可するカラムを定義(CSVインポート)
  def self.updatable_attributes
    ["food_name", "calorie", "protein", "fat", "carbo", "dietary_fiber", "sugar", "salt"]
  end
end
