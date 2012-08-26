jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.datepicker').datepicker()
  $('.timepicker').timepicker(showMeridian: false, template: 'modal', defaultTime: false)
