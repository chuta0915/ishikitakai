# coding: utf-8
require "spec_helper"

describe 'sign_in' do
  let(:new_user) { build(:new_user) }
  before do
    I18n.locale = :ja
  end
  context 'sign in with twitter account' do
    before do
      sign_in new_user, :twitter
      visit user_omniauth_authorize_path(provider: 'twitter')
    end
    it 'should have signed message' do
      page.should have_content 'Successfully authenticated from twitter account.'
    end
  end
end
