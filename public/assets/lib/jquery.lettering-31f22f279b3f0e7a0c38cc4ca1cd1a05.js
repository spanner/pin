/*global jQuery */
/*!	
* Lettering.JS 0.6.1
*
* Copyright 2010, Dave Rupert http://daverupert.com
* Released under the WTFPL license 
* http://sam.zoy.org/wtfpl/
*
* Thanks to Paul Irish - http://paulirish.com - for the feedback.
*
* Date: Mon Sep 20 17:14:00 2010 -0600
*/
(function(a){function b(b,c,d,e){var f=b.text().split(c),g="";f.length&&(a(f).each(function(a,b){g+='<span class="'+d+(a+1)+'">'+b+"</span>"+e}),b.empty().append(g))}var c={init:function(){return this.each(function(){b(a(this),"","char","")})},words:function(){return this.each(function(){b(a(this)," ","word"," ")})},lines:function(){return this.each(function(){var c="eefec303079ad17405c889e092e105b0";b(a(this).children("br").replaceWith(c).end(),c,"line","")})}};a.fn.lettering=function(b){return b&&c[b]?c[b].apply(this,[].slice.call(arguments,1)):b==="letters"||!b?c.init.apply(this,[].slice.call(arguments,0)):(a.error("Method "+b+" does not exist on jQuery.lettering"),this)}})(jQuery)