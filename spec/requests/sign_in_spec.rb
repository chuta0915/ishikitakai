# coding: utf-8
require "spec_helper"

describe 'sign_in' do
  let(:new_user) { FactoryGirl.build(:new_user) }
  before do
    I18n.locale = :ja
  end
  context 'sign in with twitter account' do
    before do
      sign_in new_user, :twitter
      visit "/users/auth/twitter"
    end
    it 'should have signed message' do
      page.should have_content 'twitterアカウントでログインしました。'
    end
  end
end
