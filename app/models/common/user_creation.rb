module Common::UserCreation
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def create_by_user attr, user
      model = self.new attr
      model.user_id = user.try(:id)
      return model unless model.valid?
      model.save
      model
    end
  end
end

