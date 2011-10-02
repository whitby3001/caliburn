// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.easing-1.3.pack
//= require jquery.fancybox-1.3.4.pack
//= require jquery.mousewheel-3.0.4.pack
//= require picnet.table.filter.min
//= require tiny_mce
//= require products
//= require_self

function nav(){
  $('div#nav ul li').mouseover(function() {
    $(this).find('ul:first').show();
  });

  $('div#nav ul li').mouseleave(function() {
    $('div#nav ul li ul').hide();
  });

  $('div#nav ul li ul').mouseleave(function() {
    $('div#nav ul li ul').hide();;
  });
};

$(document).ready(function() {
  nav();
  $('.extra-info-link').click(function(event) {
    $('.extra-info').toggle();
    event.preventDefault();
  })
  
  $('a.fancybox').fancybox({
    'titlePosition'		: 'inside'
  });
});