jQuery ->
  unless $('body').hasClass('kpts')
    return
   
  $("ul.kpt").sortable({
    connectWith: ".kpt"
    receive: (e, ui) ->
      handle_change(e, ui, @)
    update: (e, ui) ->
      handle_change(e, ui, @)
  }).disableSelection()

  handle_change = (e, ui, ref) ->
    id = $(ui.item).data('id')
    status = $(ref).data('status')
    prirority = $(ref).data('priority')
    ids = []
    $(ref).find('li').each (i, elm) ->
      ids.push $(elm).data('id')
    $.ajax
      url: location.pathname + '/' + id
      type: 'POST'
      data:
        _method: 'put'
        kpt:
          status: status
        priority_ids: ids
    return
