jQuery ->
  unless $('body').hasClass('kpts')
    return

  group_id = $('body').attr('data-id')

  # ajax
  $('form.new_kpt').live("ajax:success", (data, textStatus, jqXHR)->
    update_kpt_content()
  )

  $('a[data-method="delete"]').live("ajax:success", (data, textStatus, jqXHR)->
    update_kpt_content()
  )

  update_kpt_content = ->
    $.ajax(
      url: '/groups/' + group_id + '/kpts/'
      type: 'GET'
      success: (data) ->
        $('.kpt_content').replaceWith($(data))
        init_sortable()
        return
    )

  # UI
  init_sortable = ->
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
  init_sortable()

  # sync
  Pusher.channel_auth_endpoint = '/pusher/authentication'
  if rack_env isnt 'production'
    Pusher.log = (message) -> console.log(message)
  channel = pusher.subscribe('presence-group_kpts_' + group_id)
  channel.bind 'updated', (data) ->
    update_kpt_content()
    return
  
  channel.bind 'pusher:subscription_succeeded', (members) ->
    return

  channel.bind 'pusher:subscription_error', (data) ->
    return
