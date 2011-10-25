# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  pins = []
  map = null;
  $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script
  
  Pin = (poi) ->
    console.log "new pin:", poi
    latLng = poi.latLng || new google.maps.LatLng poi.lat, poi.lng
    console.log "latLng:", latLng
    
    properties =
      id: poi.id
      label: poi.name
      description: poi.description
      unsaved: poi.id == 'new'
      map: map
      marker: new google.maps.Marker
        position: latLng
        map: map
        title: poi.name
        draggable: true
      bubble: new google.maps.InfoWindow
      linker: $ '<a href="#">' + poi.name + '</a>'
      open: () =>
        p.close() for p in pins
        this.bubble.open this.map, this.marker
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
        console.log "pin.update", this.name
        this.linker.text(this.name)
      move: (e) =>
        console.log "pin.move", e.latLng
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
      ed = ' <a href="/pois/' + this.id + '/edit" class="edit remote">edit</a>'
      del = ' <a href="/pois/' + this.id + '/destroy" class="delete remote">delete</a>'
      content = $ '<div class="pinbox"><div class="wrapper"><h3>' + this.label + ed + del + '</h3><p>' + this.description + '</p>'
    content.enable_remote_actions
      preprocess: this.populate
      postprocess: this.update

    this.bubble.setContent(content[0])
    $('#markers').append('<li></li>').append this.linker

    this.linker.click this.open
    google.maps.event.addListener this.marker, 'dragend', this.move
    google.maps.event.addListener this.marker, 'click', this.open
    this.open() if this.unsaved
    
    pins.push this
    this



  $.fn.init_map = () ->
    this.each ->
      latlng = new google.maps.LatLng 51.5138040000, -0.0980290000
      options = 
        mapTypeId: google.maps.MapTypeId.ROADMAP
        center: latlng
        zoom: 16
      map = new google.maps.Map this, options
      markerlist = $('#markers')
      newPin = (e) =>
        console.log "newpin!"
        pin = new Pin
          id: "new"
          name: "new pin"
          latLng: e.latLng
      google.maps.event.addListener map, 'rightclick', newPin
      
  $.fn.get_pins = () ->
    $.getJSON "/pois.json", {}, (data) =>
      new Pin(poi) for poi in data

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
        else
          console.log("no match for ", value)
      console.log(parameters, mover)
      geocoder.geocode parameters, mover



