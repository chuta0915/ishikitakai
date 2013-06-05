jQuery ->
  $('textarea.auto_grow').auto_grow()
  $('textarea.tabby').tabby()

  # remote="true" な処理のlisten
  $('form[data-remote="true"]').on "submit", (e) ->
    find_key = "input[type='text'].auto_clear, textarea.auto_clear"
    $(this).find(find_key).attr "readonly", "readonly"

    $(this).bind "ajax:complete", (ee) ->
      $(this).find(find_key).removeAttr "readonly"
      $(this).find(find_key).val ""
    return
 
  # init sns button
  load_sns_script = (url) ->
    po = document.createElement("script")
    po.type = "text/javascript"
    po.async = true
    po.src = url
    s = document.getElementsByTagName("script")[0]
    s.parentNode.insertBefore po, s
    return

  load_sns_script('//apis.google.com/js/plusone.js')
  load_sns_script('//static.mixi.jp/js/plugins.js#lang=ja')
  load_sns_script('//platform.twitter.com/widgets.js')

  # add twitter bootstrap error class
  fix_style = () ->
    error = $('form .control-group .field_with_errors').parent()
    error.addClass('error')
    setTimeout (->
      error.removeClass('error')
    ),3000
    return
  fix_style()

  return
