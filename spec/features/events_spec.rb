# coding:utf-8
require 'spec_helper'

describe 'Events' do
  let(:user) { create(:user) }
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
    
    describe 'イベント作成ボタン' do
      before do
        Event.should_receive(:creatable?).and_return(creatable)
        reload
      end
      context '作成出来る場合' do
        let(:creatable) { true }
        it '新規作成ボタンが表示される' do
          page.should have_selector('a.new_event')
        end
      end

      context '作成出来ない場合' do
        let(:creatable) { false }
        it '新規作成ボタンが表示されない' do
          page.should_not have_selector('a.new_event')
        end
      end
    end
  end
end
