module CssBadgeHelper
  def css_scope_badge(scope)
    classes = {
      public: 'label-success',
      friends: 'label-important',
      friends_friends: 'label-warning',
      closed: 'label-info',
      private: 'label-inverse',
    }
    classes[scope.name.to_sym]
  end
  
  def css_event_payment_kind_badge(payment_kind)
    classes = {
      free: 'label-success',
      advance: 'label-important',
      deferred: 'label-warning',
    }
    classes[payment_kind.name.to_sym]
  end

  def css_level_badge(level)
    classes = {
      master: 'label-important',
      support: 'label-info',
      member: 'label-success',
      guest: 'label',
      pending: 'label',
    }
    classes[level.name.to_sym]
  end
end
