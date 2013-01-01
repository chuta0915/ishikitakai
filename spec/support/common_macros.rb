module CommonMacros
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def ancestors_should_include ancestors
      describe 'ancestors' do
        ancestors = [ancestors] unless ancestors.instance_of? Array
        ancestors.each do |ancestor|
          it {subject.class.ancestors.should be_include ancestor}
        end
      end
    end
  end
end
