require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    
    config.time_zone = 'Asia/Tokyo' 
    
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # Rspec
    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false, 
        helper_specs: false, 
        controller_specs: false, 
        routing_specs: false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

require 'charlock_holmes'
require 'csv'

# CSVファイルのパスを指定
path = 'path/to/file.csv'

# ファイルをすべて読み込んで（大きなファイルは、メモリに優しくない）
# エンコードを推測（あくまで推測）
detection = CharlockHolmes::EncodingDetector.detect(File.read(path))
# => {:type=>:text, :encoding=>"Shift_JIS", :ruby_encoding=>"Shift_JIS", :confidence=>100, :language=>"ja"}

# CharlockHolmes::EncodingDetectorのディテクション結果は、
# CP932であるShift JIS拡張文字コードを含む場合にもShift_JISと見なされてしまう為、CP932を優先して利用する。
# もしそのままShift JISを指定すれば、CSV.foreach()で変換エラーが出る原因となる。
# アップサイドは拡張文字コードを変換できることで、ダウンサイドは7種類の記号文字の見た目が完全に一致しないこと。
encoding = detection[:encoding] == 'Shift_JIS' ? 'CP932' : detection[:encoding]

# CSVを1行ずつUTF-8として読み込む（メモリに優しい！）
CSV.foreach(path,
            encoding: "#{encoding}:UTF-8",
            headers: true) do |row|
  p row.inspect
end
