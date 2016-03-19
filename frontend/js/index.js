import $ from 'jquery'
import './lib/modal'
import Router from './router'

// href='#' なリンクを無効にする
$('a').on('click', (event) => {
  if ( event.target.href.match(/#$/) ) {
    event.preventDefault();
  }
});

var router = new Router( window.Rails.request );
router.route( window.Rails.params );
