window.onload = ->

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
      document.getElementById('alert').style.display = 'block'
      #$('alert').show()

    toggle = document.getElementById('toggle_position')
    if toggle
      toggle.onclick = ->
        navigator.geolocation.getCurrentPosition success, error, options

  else
    console.log('no geolocation')
    document.getElementById('alert').style.display = 'none'

