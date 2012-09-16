module Common::Markdown
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
  end

  def content_md
    c = self.content
    c = '' if c.nil?
    c.gsub! /\t/, '  '
    c.to_md
  end
end
