# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  markers = []
  infowindows = []
  map = null;
  markerlist = null;
  
  $.fn.init_map = () ->
    this.each ->
      latlng = new google.maps.LatLng 51.5138040000, -0.0980290000
      options = 
        mapTypeId: google.maps.MapTypeId.ROADMAP
        center: latlng
        zoom: 14
      map = new google.maps.Map this, options
      markerlist = $('#markers')
      google.maps.event.addListener map, 'singlerightclick', $.create_pin
      
  $.fn.init_pins = () ->
    $.getJSON "/pois.json", {}, (data) =>
      this.add_pin(poi) for poi in data

  $.fn.add_pin = (poi) ->
    this.each ->
      bubble = $ '<div class="pinbox"><div class="wrapper"><h3>' + poi.name + ' <a class="edit remote" href="/pois/' + poi.id + '/edit">edit</a></h3><p>' + poi.description + '</p></div></div>'
      bubble.enable_remote_actions()
      marker = new google.maps.Marker
        position: new google.maps.LatLng poi.lat, poi.lng
        map: map
        title: poi.name
        draggable: true
      infowindow = new google.maps.InfoWindow
        content: bubble[0]
      listing = $ '<li><a href="#">' + poi.name + "</a></li>"

      openWindow = (e) ->
        infowindow.open map, marker
      updateLatLng = (e) ->
        console.log e.latLng
        
      markers.push marker
      infowindows.push infowindow
      markerlist.append listing

      (listing.find "a").click openWindow
      google.maps.event.addListener marker, 'click', openWindow
      google.maps.event.addListener marker, 'dragend', updateLatLng



  $.create_pin = (e) ->
    console.log "create_pin"
  
