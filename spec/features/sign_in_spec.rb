# coding: utf-8
require "spec_helper"

describe 'sign_in' do
  let(:new_user) { build(:new_user) }
  before do
    I18n.locale = :ja
  end
  [:facebook, :twitter, :github].each do |provider|
    context "sign in with #{provider.to_s} account" do
      before do
        oauth_sign_in new_user, provider, false
      end
      it 'should have signed message' do
        page.should have_content "#{provider.to_s}アカウントでログインしました。"
      end
      it '通知メニューが表示される' do
        within('body>div.navbar') do
          page.should have_content(I18n.t('nav.notification'))
        end
      end
      it 'ログインしたユーザーの名前が表示される' do
        within('body>div.navbar') do
          page.should have_content(new_user.name)
        end
      end
      it 'ログインしたユーザーの画像が表示される' do
        within('body>div.navbar') do
          page.should have_selector("img[src='#{new_user.image}']")
        end
      end
    end
  end
end
