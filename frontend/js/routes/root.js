import Carousel from '../lib/carousel'

export default function(req) {
  switch (req.action) {

    case 'index': return function() {
      var carousel = new Carousel('#mainCarousel');
      carousel.start();
    }

  }
}
