# encoding: utf-8
require 'spec_helper'
describe EventDateHelper do
  describe 'event_date_formatted' do
    subject { helper }
    context 'when 1day span' do
      subject {
        helper.event_date_formatted(Time.parse("2012-08-01 10:00:00"), 
                                    Time.parse("2012-08-01 12:00:00"))
      }
      context 'when locale is en' do
        before do
          I18n.locale = :en
        end
        it { should == '10:00 - 12:00 01 Aug 2012' }
      end
      context 'when locale is en' do
        before do
          I18n.locale = :ja
        end
        it { should == '2012年08月01日 10:00 〜 12:00' }
      end
    end

    context 'when more than 2day span' do
      subject {
        helper.event_date_formatted(Time.parse("2012-08-01 10:00:00"), 
                                    Time.parse("2012-08-31 12:00:00"))
      }
      context 'when locale is en' do
        before do
          I18n.locale = :en
        end
        it { should == '10:00 01 Aug 2012 - 12:00 31 Aug 2012' }
      end
      context 'when locale is en' do
        before do
          I18n.locale = :ja
        end
        it { should == '2012年08月01日 10:00 〜 2012年08月31日 12:00' }
      end
    end
  end
end
