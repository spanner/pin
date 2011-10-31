#  This is a manifest file that'll be compiled into including all the files listed below.
#  Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
#  be included in the compiled file accessible from http://example.com/assets/application.js
#  It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
#  the compiled file.
# 
#= require jquery
#= require jquery_ujs
#= require lib/modernizr
#= require lib/jquery.lettering
#= require_tree .
$ ->
  $('#map_canvas').init_map().add_procession().add_fireworks()
  $('form.where').geolocator()
  $('a.cat').category_toggler()
  true