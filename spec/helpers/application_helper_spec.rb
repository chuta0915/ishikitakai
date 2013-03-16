require 'spec_helper'
describe ApplicationHelper do
  let!(:user) { create(:user) }
  describe 'fb_connect_js' do
    subject { helper.fb_connect_js }
    context 'when locale is not specified' do
      before do
        I18n.locale = nil
      end
      it { should === '//connect.facebook.net/en_US/all.js' }
    end
    context 'when locale is en' do
      before do
        I18n.locale = :en
      end
      it { should === '//connect.facebook.net/en_US/all.js' }
    end
    context 'when locale is ja' do
      before do
        I18n.locale = :ja
      end
      it { should === '//connect.facebook.net/ja_JP/all.js' }
    end
  end

  describe 'locale_key' do
    subject { helper.locale_key }
    context 'when user signed in' do
      before do
       sign_in user 
      end
      it { should === 'add' }
    end
    context 'when user not signed in' do
      it { should === 'new' }
    end
  end

  describe 'content_for_sidebar' do
    before do
      helper.content_for_sidebar 'content'
    end
    it { helper.content_for?(:sidebar).should be_true }
    it { helper.content_for?(:main_span).should be_true }
  end
end
