module Common::Markdown
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
  end

  def content_md
    c = super
    c = '' if c.nil?
    c.to_md
  end
end
