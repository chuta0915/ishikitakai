require 'spec_helper'

describe Kpt do
  describe 'const' do
    it { Kpt::KEEP.should == 1 }
    it { Kpt::PROBLEM.should == 2 }
    it { Kpt::TRY.should == 3 }
  end
end
