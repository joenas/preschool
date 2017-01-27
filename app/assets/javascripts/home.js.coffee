$ ->
  if ("geolocation" of navigator)
    options =
      timeout: 2500
      maximumAge: 0

    success = (pos) ->
      crd = pos.coords
      console.log(crd.latitude, crd.longitude)
      window.location = "/position/#{crd.latitude},#{crd.longitude}"

    error = (err) ->
      console.warn('Couldnt get position')
      $('.alert').show()

    $('#toggle_position').on 'click', ->
      navigator.geolocation.getCurrentPosition success, error, options

  else
    console.log('no geolocation')
    $('.alert').show()

