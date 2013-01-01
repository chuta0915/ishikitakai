module ControllerMacros
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def request_should_be_success method, path, params = {}
      describe "#{method.to_s.upcase} '#{path.to_s}'" do
        before do
          send method, path, params
        end
        subject { response }
        it "response should returns http success" do
          should be_success
        end
      end
    end
  end
end
