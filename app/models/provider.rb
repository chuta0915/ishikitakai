class Provider < ActiveRecord::Base
  attr_accessible :name
  default_scope order(:id)

  class << self
    Provider.all.each do|provider|
      define_method provider.name do
        find_by_provider_name provider.name 
      end
    end

    private
    def find_by_provider_name provider_name
      Rails.cache.fetch("model_provider_#{provider_name}", expires_in: 365.days) do
        select(:id).find_by_name(provider_name)
      end
    end
  end 
end
