require 'rails_helper'

RSpec.describe 'Users', type: :system do
  
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # usernameテキストフィールドにyusaと入力
            fill_in 'user_username', with: 'yusa'
            # emailテキストフィールドにyusa@email.comと入力
            fill_in 'user_email', with: 'yusa@email.com'
            # passwordテキストフィールドにpasswordと入力
            fill_in 'user_password', with: 'password'
            # password confirmationテキストフィールドにpasswordと入力
            fill_in 'user_password_confirmation', with: 'password'
            # 登録と記述のあるsubmitをクリックする
            click_button '登録'
            # new_user_bmr_pathへ遷移することを期待する
            expect(current_path).to eq new_user_bmr_path(1)
            # 遷移されたページに'基本設定'の文字列があることを期待する
            expect(page).to have_content '基本設定'
            
          end
        end
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # usernameテキストフィールドにyusaと入力
            fill_in 'user_username', with: 'yusa'
            # emailテキストフィールドをnil状態にする
            fill_in 'user_email', with: nil
            # passwordテキストフィールドにpasswordと入力
            fill_in 'user_password', with: 'password'
            # password confirmationテキストフィールドにpasswordと入力
            fill_in 'user_password_confirmation', with: 'password'
            # 登録と記述のあるsubmitをクリックする
            click_button '登録'
            # user_registration_pathへ遷移することを期待する
            expect(current_path).to eq user_registration_path
            # 遷移されたページに'アカウント登録'の文字列があることを期待する
            expect(page).to have_content "アカウント登録"
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗する' do
            # ユーザー新規登録画面へ遷移
            visit new_user_registration_path
            # usernameテキストフィールドにyusaと入力
            fill_in 'user_username', with: 'yusa'
            # emailテキストフィールドをnil状態にする
            fill_in 'user_email', with: user.email
            # passwordテキストフィールドにpasswordと入力
            fill_in 'user_password', with: 'password'
            # password confirmationテキストフィールドにpasswordと入力
            fill_in 'user_password_confirmation', with: 'password'
            # 登録と記述のあるsubmitをクリックする
            click_button '登録'
            # user_registration_pathへ遷移することを期待する
            expect(current_path).to eq user_registration_path
            # 遷移されたページに'アカウント登録'の文字列があることを期待する
            expect(page).to have_content "アカウント登録"
          end
        end
      end
    end
    describe 'ログイン後' do
      before { login_as(user) }
      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集が成功' do
            visit edit_user_registration_path
            fill_in 'user_username', with: 'test'
            fill_in 'user_email', with: 'test@email.com'
            fill_in 'user_current_password', with: user.password
            click_button '更新'
            expect(current_path).to eq edit_user_registration_path
            expect(page).to have_content 'ユーザー編集'
          end
        end
        context 'メールアドレスが未入力' do
          it 'ユーザーの編集が失敗' do
            visit edit_user_registration_path
            fill_in 'user_username', with: 'test'
            fill_in 'user_email', with: nil
            fill_in 'user_current_password', with: user.password
            click_button '更新'
            expect(current_path).to eq user_registration_path
            expect(page).to have_content "現在のパスワードを入力してください"
          end
        end
      end
    end
  end
end