# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  pins = []
  catpins = {}
  map = null;
  $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script
  
  size = new google.maps.Size 36, 36
  origin = new google.maps.Point 0, 0
  anchor = new google.maps.Point 18, 36
  markers = 
    processional: new google.maps.MarkerImage '/pins/coach.png', size, origin, anchor
    building: new google.maps.MarkerImage '/pins/building.png', size, origin, anchor
    toilet: new google.maps.MarkerImage '/pins/loo.png', size, origin, anchor
    accessible: new google.maps.MarkerImage '/pins/accessible_loo.png', size, origin, anchor
    tube: new google.maps.MarkerImage '/pins/tube.png', size, origin, anchor
    rail: new google.maps.MarkerImage '/pins/station.png', size, origin, anchor
    waterbus: new google.maps.MarkerImage '/pins/pier.png', size, origin, anchor
    walk: new google.maps.MarkerImage '/pins/walk.png', size, origin, anchor
    fireworks: new google.maps.MarkerImage '/pins/fireworks.png', size, origin, anchor
    firstaid: new google.maps.MarkerImage '/pins/redcross.png', size, origin, anchor
    museum: new google.maps.MarkerImage '/pins/museum.png', size, origin, anchor
    history: new google.maps.MarkerImage '/pins/historical.png', size, origin, anchor
    information: new google.maps.MarkerImage '/pins/information.png', size, origin, anchor
    protest: new google.maps.MarkerImage '/pins/protest.png', size, origin, anchor
    plain: new google.maps.MarkerImage '/pins/plain.png', size, origin, anchor
    shadow: new google.maps.MarkerImage '/pins/shadow.png', size, origin, anchor
  
  Pin = (poi) ->
    latLng = poi.latLng || new google.maps.LatLng poi.lat, poi.lng
    marker_icon = markers[poi.icon] || markers['plain']
    properties =
      id: poi.id
      name: poi.name
      icon: poi.icon
      cat: poi.cat
      description: poi.description
      unsaved: poi.id == 'new'
      map: map
      marker: new google.maps.Marker
        position: latLng
        map: map
        title: poi.name
        draggable: true
        icon: marker_icon
        shadow: markers['shadow']
      bubble: new google.maps.InfoWindow
      linker: $ '<a href="#">' + poi.name + '</a>'
      hide: () =>
        this.close()
        this.marker.setMap null
        this.linker.addClass('disabled')
      show: () =>
        this.marker.setMap this.map
        this.linker.removeClass('disabled')
      open: () =>
        p.close() for p in pins
        this.bubble.open this.map, this.marker
      open_if_enabled: () =>
        this.open() unless this.linker.hasClass('disabled')
      close: () =>
        this.bubble.close()
      cancel: () =>
        this.marker.setMap(null) if this.unsaved
        this.close()
      update: (data) =>
        heading = $(data).find('h3')
        label = heading.text().replace ' edit', ''
        this.id = heading.attr('id')
        this.name = label
        this.linker.text(this.name)
        cat = heading.attr('class')
        if cat && cat != this.cat
          if oldcatpin = catpins[this.cat].indexOf this
            catpins[this.cat].splice oldcatpin, 1
          catpins[cat].push this
          this.cat = cat
          new_icon = markers[cat] || markers['plain']
          this.marker.setIcon(new_icon)
      move: (e) =>
        this.marker.setAnimation(google.maps.Animation.BOUNCE)
        this.linker.addClass('waiting')
        finished = () =>
          this.marker.setAnimation(null)
          this.linker.removeClass('waiting')
        $.ajax
          url: "/pois/" + this.id + ".json"
          dataType: 'json'
          data:
            poi:
              lat: e.latLng.lat()
              lng: e.latLng.lng()
          type: "PUT"
          success: finished
      populate: (form) =>
        if this.unsaved
          (form.find 'span.lat').text this.marker.position.lat()
          (form.find 'span.lng').text this.marker.position.lng()
          (form.find 'input.lat').val this.marker.position.lat()
          (form.find 'input.lng').val this.marker.position.lng()
          (form.find 'a.cancel').click this.cancel
    $.extend this, properties
    
    content = ''
    if this.unsaved
      content = $ '<div class="pinbox"><div class="wrapper"><a href ="/pois/new" class="remote autoload">New Pin</a></div></div>'
    else
      img = '<img src="' + poi.image + '" width="320" height="240" class="img" />' if poi.image
      img ?= ''
      ed = ' <a href="/pois/' + this.id + '/edit" class="edit remote">edit</a>'
      del = ' <a href="/pois/' + this.id + '/destroy" class="delete remote">delete</a>'
      title = '<a href="' + poi.url + '">' + poi.name + '</a>' if poi.url
      title ?= poi.name
      content = $ '<div class="pinbox"><div class="wrapper">' + img + '<h3>' + title + ed + del + '</h3><p>' + this.description + '</p><p>Category: ' + this.cat + '</p>'

    content.enable_remote_actions
      preprocess: this.populate
      postprocess: this.update
    this.bubble.setContent(content[0])
    $('#markers').append('<li></li>').append this.linker

    this.linker.click this.open_if_enabled
    google.maps.event.addListener this.marker, 'dragend', this.move
    google.maps.event.addListener this.marker, 'click', this.open
    this.open() if this.unsaved
    
    pins.push this
    catpins[this.cat] ?= []
    catpins[this.cat].push this
    this


  $.fn.init_map = () ->
    this.each ->
      latlng = new google.maps.LatLng 51.5094737914 , -0.1111965698
      options = 
        mapTypeId: google.maps.MapTypeId.ROADMAP
        center: latlng
        zoom: 16
      map = new google.maps.Map this, options
      markerlist = $('#markers')
      newPin = (e) =>
        pin = new Pin
          id: "new"
          name: "new pin"
          latLng: e.latLng
      google.maps.event.addListener map, 'rightclick', newPin
      
  $.fn.get_pins = () ->
    $.getJSON "/pois.json", {}, (data) =>
      new Pin(poi) for poi in data
    this

  $.fn.add_procession = () ->
    sw = new google.maps.LatLng 51.5059409, -0.1159503
    ne = new google.maps.LatLng 51.5178074, -0.0859706
    edges = new google.maps.LatLngBounds sw, ne
    console.log edges
    procession = new google.maps.GroundOverlay "/overlays/procession_map.jpg", edges
    console.log procession
    procession.setMap map
    this

  $.fn.add_fireworks = () ->
    sw = new google.maps.LatLng 51.5042003, -0.1238055
    ne = new google.maps.LatLng 51.5145567, -0.10050325
    edges = new google.maps.LatLngBounds sw, ne
    console.log edges
    fireworks = new google.maps.GroundOverlay "/overlays/fireworks_144dpi.jpg", edges
    console.log fireworks
    fireworks.setMap map
    this

  $.fn.geolocator = () ->
    geocoder = new google.maps.Geocoder()
    this.submit (e) ->
      e.preventDefault()
      field = $(this).find('input')
      value = field.val() + ", London"
      parameters = 
        address: value
        region: "GB"
      mover = (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          map.panTo results[0].geometry.location
      geocoder.geocode parameters, mover

  $.fn.category_toggler = () ->
    this.each ->
      ($ this).click (e) ->
        link = $ this
        cat = link.attr('rel')
        if catpins[cat]
          if link.hasClass('disabled')
            link.removeClass('disabled')
            pin.show() for pin in catpins[cat]
          else
            link.addClass('disabled')
            pin.hide() for pin in catpins[cat]
        