# encoding: utf-8
require 'spec_helper'
describe CssBadgeHelper do
  Scope.all.each do |s|
    describe "#{s.label} css_scope_badge" do
      subject {
        helper.css_scope_badge s
      }
      it { should be_present }
    end
  end

  EventPaymentKind.all.each do |e|
    describe "#{e.label} css_event_payment_kind_badge" do
      subject {
        helper.css_event_payment_kind_badge e
      }
      it { should be_present }
    end
  end

  Level.all.each do |l|
    describe "#{l.label} css_level_badge" do
      subject {
        helper.css_level_badge l
      }
      it { should be_present }
    end
    
  end
end
