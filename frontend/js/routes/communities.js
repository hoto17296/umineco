import $ from 'jquery'

export default function(req) {
  switch (req.action) {

    case 'show': return function() {

      // サイドバ―固定
      var $eventAction = $("#eventAction");
      var $main = $(".eventBody__left");
      var eventAction_offset_top = $eventAction.offset().top;
      var main_offset_top = $main.offset().top;
      var sub_scroll = main_offset_top + $main.outerHeight(true) - $eventAction.outerHeight(true);

      if ($eventAction.outerHeight(true) + eventAction_offset_top < $main.outerHeight(true) + main_offset_top) {
        $(window).scroll(function () {
          var ws = $(window).scrollTop();
          if (ws > sub_scroll) {
            $eventAction.css({position:'fixed', top: sub_scroll - ws + 'px'});
          } else if(ws > eventAction_offset_top) {
            $eventAction.css({position:'fixed', top: '0px'});
          } else {
            $eventAction.css({position:'relative', top: '0px'});
          }
        })
      }

    }
  }
}
