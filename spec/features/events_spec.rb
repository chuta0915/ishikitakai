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
    
    it { page.status_code.should == 200 }
    it { page.should have_content('Free') }
    it { page.should have_selector('input[name="keyword"]') }
    it { page.should have_selector("a[href='#{event_path(event)}']") }
  end
end
