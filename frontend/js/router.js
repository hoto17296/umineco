import config from './router.config'

class Router {

  constructor(req) {
    if ( typeof req !== 'object' ) {
      throw new Error('Request object is required.');
    }
    this.request = req;
  }

  route(params) {
    var controller = config[ this.request.controller ];
    if ( ! controller ) {
      throw new Error('Undefined controller.');
    }
    var action = controller( this.request );
    if ( ! action ) {
      throw new Error('Undefined action.');
    }
    return action(params);
  }

}

export default Router
