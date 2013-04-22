# coding:utf-8
require 'spec_helper'

describe 'Users' do
  before do
    I18n.locale = :ja
  end
  describe 'visit events list' do
    let!(:event) { FactoryGirl.create(:mokmok_event) }
    before do
      visit events_path
    end

    it '検索フォームが表示される' do
      page.should have_selector('input[name="keyword"]')
    end

    it '登録されているイベントが表示される' do
      page.should have_content(event.name)
    end
  end
end
