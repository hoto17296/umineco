import 'jquery'
import './lib/modal'
import Router from './router'

var router = new Router( window.Rails.request );
router.route( window.Rails.params );
