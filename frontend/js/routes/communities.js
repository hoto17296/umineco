import $ from 'jquery'

export default function(req) {
  switch (req.action) {

    case 'show': return function() {

      function photoGallary() {
        // 写真ギャラリー
        var $main = $(".main");
        var $thumbnails = $(".thumbnails");
        var $mainItems = $main.find(".mainItem");
        var $thumbnailsItems = $thumbnails.find(".thumbnailsItem");
        var mainCount = 0;
        var pageCount = 0;
        var mainLimit = $mainItems.size();
        var thumbnailsLimit = $thumbnailsItems.size();
        var thumbnailPageSize = 5;
        var pageMax =  Math.ceil(thumbnailsLimit / thumbnailPageSize);
        var pageWidth = 100 / thumbnailsLimit * thumbnailPageSize;
        $thumbnailsItems.first().addClass("current");

        function showPhoto(n) {
          $main.css("transform", "translateX( -" + (100 / mainLimit * n) + "%)");
          $thumbnailsItems.removeClass("current");
          $thumbnailsItems.eq(n).addClass("current");
          mainCount = n;

          pageCount = Math.floor(n / thumbnailPageSize);
          $thumbnails.css("transform", "translateX( -" + ( pageWidth * pageCount ) + "%)");
        }

        $(".mainBox .next").on('click', function() {
          if(mainCount < mainLimit - 1) {
            showPhoto(mainCount + 1);
          }
        });

        $(".mainBox .prev").on('click', function() {
          if(mainCount > 0) {
            showPhoto(mainCount - 1);
          }
        });

        $thumbnailsItems.on('click', function() {
          // サムネイルがクリックされた番号
          var index = $thumbnailsItems.index(this);
          showPhoto(index);
        });

        $(".thumbnailsBox .next").on('click', function() {

          if(pageCount < pageMax -1 ) {
            $thumbnails.css("transform", "translateX( -" + ( pageWidth * ( pageCount + 1) ) + "%)");
            pageCount++;
          }
        });

        $(".thumbnailsBox .prev").on('click', function() {
          if(pageCount > 0 ) {
            $thumbnails.css("transform", "translateX( -" + ( pageWidth * ( pageCount - 1) ) + "%)");
            pageCount--;
          }
        });
      }
      photoGallary();


      if ( ! req.sp ) {
        // PC サイドバ―固定
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
      // スマホ
      else {
        // SP 一緒に遊ぶボタン固定
        var $eventActionScroll = $(".eventActionScroll");
        var $eventArea = $(".event");
        var eventArea_offset_top = $eventArea.offset().top;
        var windowHeight = $(window).height();
        var sub_scroll = eventArea_offset_top + $eventArea.outerHeight(true) - $eventActionScroll.outerHeight(true) - windowHeight;

        $(window).scroll(function () {
          var ws = $(window).scrollTop();
          if (ws > sub_scroll) {
            $eventActionScroll.css({position:'absolute', bottom: '0px'});
          } else {
            $eventActionScroll.css({position:'fixed', bottom: '0px'});
          }
        })
      }
    }
  }
}
