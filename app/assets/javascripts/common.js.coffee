jQuery ->
  $('textarea.auto_grow').auto_grow()

  # remote="true" な処理のlisten
  $('form[data-remote="true"]').live "submit", (e) ->
    find_key = "input[type='text'].auto_clear, textarea.auto_clear"
    $(this).find(find_key).attr "readonly", "readonly"

    $(this).bind "ajax:complete", (ee) ->
      $(this).find(find_key).removeAttr "readonly"
      $(this).find(find_key).val ""
    return
