import 'jquery'
import Router from './router'

var router = new Router( window.Rails.request );
router.route( window.Rails.params );
