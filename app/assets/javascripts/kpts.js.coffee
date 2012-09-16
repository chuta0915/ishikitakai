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

  Pusher.channel_auth_endpoint = '/pusher/authentication'
  if rack_env isnt 'production'
    Pusher.log = (message) -> console.log(message)
  group_id = $('body').attr('data-id')
  channel = pusher.subscribe('presence-group_kpts_' + group_id)
  channel.bind 'updated', (data) ->
    $.ajax(
      url: '/groups/' + group_id + '/kpts/'
      success: (data) ->
        $('.kpt_content').replaceWith($(data))
        return
    )
    return
  
  channel.bind 'pusher:subscription_succeeded', (members) ->
    return

  channel.bind 'pusher:subscription_error', (data) ->
    return
