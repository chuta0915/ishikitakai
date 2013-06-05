# coding:utf-8
require 'spec_helper'

describe 'Event' do
  let(:user) { create(:user) }
  let!(:public_group) { create(:sendagayarb, user_id: user.id) }
  let!(:private_group) { create(:ishikitakai, user_id: user.id) }
  let!(:public_event) { create(:mokmok_event) }
  let!(:private_event) { create(:private_event) }
  let!(:public_group_event) { create(:reading_event, group: public_group) }
  let!(:private_group_event) { create(:drinkup_event, group: private_group) }
  before do
    I18n.locale = :ja
  end

  describe 'イベント詳細' do
    before do
      visit event_path(event)
    end
    context 'グループのイベント' do
      let(:event) { public_group_event }
      it 'グループメニューが表示される' do
        page.should have_selector('.group_menu')
      end
    end

    context '単発イベント' do
      let(:event) { public_event }
      it 'グループメニューが表示されない' do
        page.should_not have_selector('.group_menu')
      end
    end
  end
end 
