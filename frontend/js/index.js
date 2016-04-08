import $ from 'jquery'
import './lib/modal'
import Router from './router'

// スムーズスクロール
$('a[href^="#"]').click(function(event) {
  event.preventDefault();
  var href= $(this).attr("href");
  if ( href === '#' ) return;
  var speed = 400;
  var position = $(href).offset().top;
  $('body,html').animate({scrollTop:position}, speed, 'swing');
});

var router = new Router( window.Rails.request );
router.route( window.Rails.params );
