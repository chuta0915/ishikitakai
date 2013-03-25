require 'spec_helper'

describe Admin do
  ancestors_should_include ActiveRecord::Base
  let(:admin) { create :admin }
  describe 'create' do
    it { admin.should be_persisted }
  end
end
