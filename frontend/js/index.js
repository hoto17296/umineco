import $ from 'jquery'
import './lib/modal'
import Router from './router'

// スムーズスクロール
$('a[href^="#"]').click(function(event) {
  event.preventDefault();
  var speed = 400;
  var href= $(this).attr("href");
  var position = $(href).offset().top;

  if(href != "#") {
    $('body,html').animate({scrollTop:position}, speed, 'swing');
  }
});

var router = new Router( window.Rails.request );
router.route( window.Rails.params );
