module ApplicationHelper
  def fb_connect_js opts = {}
    uri = "//connect.facebook.net/{locale}/all.js"
    case I18n.locale
      when :ja
        uri.sub '{locale}', 'ja_JP'
      else
        uri.sub '{locale}', 'en_US'
    end
  end

  def locale_key
    user_signed_in? ? 'add' : 'new'
  end

  def content_for_sidebar content =nil, &block
    block_given? ? content_for(:sidebar, &block) : content_for(:sidebar, content)
    content_for(:main_span, 'span9') unless content_for?(:main_span)
  end
end
