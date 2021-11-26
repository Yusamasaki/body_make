class ApifoodsController < ApplicationController
  
  def index
    #値に日本語が入っていてもAPIに正しくリクエストできるよう、コード化（エスケープ）する
    # valueはFormとかでユーザから受け付けた検索のキーワード（ex.ハンバーグの栄養素を検索するならvalue="ハンバーグ"）
    @params = URI.escape(value)
    
    #上で取得した値をリクエストに組み込む
     uri = URI.parse("https://apex.oracle.com/pls/apex/body_make/food/food/{food_name}/#{@params}")
    
    #ここでAPIのリクエストを実行してる（多分）
    json = Net::HTTP.get(uri)
    
    #json形式のオブジェクトをハッシュに変換してる（多分）
    @result = JSON.parse(json)
    
    #@resultはハッシュなので、キーを指定する必要がある
    #（当たり前のことだけど正直ここが一番ハマった。@result[food_name]で取得できると勘違い）
    @food_hash = @result['items']
  end
  
end
