# coding:utf-8
require 'spec_helper'

describe 'Events' do
  let(:user) { create(:user) }
  before do
    I18n.locale = :ja
  end

  describe 'イベント一覧' do
    let!(:public_group) { create(:sendagayarb, user_id: user.id) }
    let!(:private_group) { create(:ishikitakai, user_id: user.id) }
    let!(:public_event) { create(:mokmok_event) }
    let!(:private_event) { create(:private_event) }
    let!(:public_group_event) { create(:reading_event, group: public_group) }
    let!(:private_group_event) { create(:drinkup_event, group: private_group) }
    before do
      visit events_path
    end

    it '検索フォームが表示される' do
      page.should have_selector('input[name="keyword"]')
    end

    it '登録されているイベントが表示される' do
      page.should have_content(public_event.name)
    end

    it '登録されている非公開イベントは表示されない' do
      page.should_not have_content(private_event.name)
    end

    describe 'イベント詳細へ移動' do
      context 'イベントタイトルをクリック' do
        before do
          find_link(public_event.name).click()
        end
        it 'イベント詳細へ移動する' do
          page.current_path.should eq event_path(public_event)
        end
      end
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

    describe '検索' do
      before do
        within('form[action="/events"]') do
          find('input[name="keyword"]').set(keyword)
          find('input[type="submit"]').click()
        end
      end
      context '検索結果が存在する場合' do
        context '公開イベントの場合' do
          let(:keyword) { public_event.name }
          it '検索結果が表示されること' do
            page.should have_content(public_event.name)
          end
        end

        context '非公開イベントの場合' do
          let(:keyword) { private_event.name }
          it '検索結果が表示されないこと' do
            page.should have_content(I18n.t('events.index.not_found'))
          end
        end

        context '公開グループのイベントの場合' do
          let(:keyword) { public_group_event.name }
          it '検索結果が表示されること' do
            page.should have_content(public_group_event.name)
          end
        end

        context '非公開グループのイベントの場合' do
          let(:keyword) { private_group_event.name }
          it '検索結果が表示されないこと' do
            page.should have_content(I18n.t('events.index.not_found'))
          end
        end
      end

      context '検索結果が存在しない場合' do
        let(:keyword) { 'hoge hoge hoge' }
        it '検索結果が表示されないこと' do
          page.should have_content(I18n.t('events.index.not_found'))
        end
      end
    end
  end
end
