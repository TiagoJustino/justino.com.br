$ = jQuery
$ ->
  $('.flag').css('cursor', 'pointer')
  $('#brflag').click ->
    $('.english').hide('fast')
    $('.portuguese').show('fast')
  $('#enflag').click ->
    $('.portuguese').hide('fast')
    $('.english').show('fast')
