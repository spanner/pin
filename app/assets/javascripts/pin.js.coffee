# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  markers = []
  bubbles = []
  map = null;
  markerlist = null;
  $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script
  
  $.fn.init_map = () ->
    this.each ->
      latlng = new google.maps.LatLng 51.5138040000, -0.0980290000
      options = 
        mapTypeId: google.maps.MapTypeId.ROADMAP
        center: latlng
        zoom: 14
      map = new google.maps.Map this, options
      markerlist = $('#markers')
      newPin = (e) ->
        pin = $.pinAt(e.latLng, 'new pin')
        bubble = $.bubbleFor pin
      google.maps.event.addListener map, 'rightclick', newPin
      
  $.fn.init_pins = () ->
    $.getJSON "/pois.json", {}, (data) =>
      this.add_pin(poi) for poi in data

  $.fn.add_pin = (poi) ->
    this.each ->
      latlng = new google.maps.LatLng poi.lat, poi.lng
      marker = $.pinAt latlng, poi.name
      bubble = $.bubbleFor marker, poi
      markers.push marker

      updateLatLng = (e) ->
        console.log e.latLng
        
      google.maps.event.addListener marker, 'dragend', updateLatLng

  $.pinAt = (latlng, title) ->
    marker = new google.maps.Marker
      position: latlng
      map: map
      title: title
      draggable: true

  $.bubbleFor = (marker, poi) ->
    poi ?= 
      id: 'new'

    bubble = new google.maps.InfoWindow
    bubbles.push bubble
    
    openWindow = (e) ->
      other.close() for other in bubbles
      bubble.open map, marker
    closeWindow = (e) ->
      bubble.close()
    forgetWindow = (e) ->
      bubble.close()
      if poi.id == 'new'
        marker.setMap(null)

    if poi.id == 'new'
      content = $ '<div class="pinbox"><div class="wrapper"><a href ="/pois/new" class="remote autoload">New Pin</a></div></div>'
      openWindow()
    else
      ed = ' <a href="/pois/' + poi.id + '/edit" class="edit remote">edit</a>'
      del = ' <a href="/pois/' + poi.id + '/destroy" class="delete remote">delete</a>'
      content = $ '<div class="pinbox"><div class="wrapper"><h3>' + poi.name + ed + del + '</h3><p>' + poi.description + '</p>'

    processForm = () ->
      latlng = marker.position
      (content.find 'span.lat').text latlng.lat()
      (content.find 'span.lng').text latlng.lng()
      (content.find 'input.lat').val latlng.lat()
      (content.find 'input.lng').val latlng.lng()
      if poi.id == 'new'
        (content.find 'a.cancel').click forgetWindow
      else
        (content.find 'a.cancel').click closeWindow
        
    content.enable_remote_actions
      process_form: processForm
      
    bubble.setContent(content[0])

    google.maps.event.addListener marker, 'click', openWindow

    if poi.id != 'new'
      listing = $ '<li><a href="#">' + poi.name + "</a></li>"
      markerlist.append listing
      (listing.find "a").click openWindow
 
  $.deletePoi = (id) ->
    if confirm "really delete that pin?"
      # delete that pin
    
    