export default function(req) {
  switch (req.action) {

    case 'show': return function() {
      console.log('sailing page!');
    }

  }
}
