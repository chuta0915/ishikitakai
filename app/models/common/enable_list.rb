module Common::EnableList
  def self.included(base)
    base.scope :enable_list, lambda {
      base.where('priority > 0').order(:priority)
    } 
  end
end
