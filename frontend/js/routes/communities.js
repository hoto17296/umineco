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

        $(".thumbnailsBox .prev a").hide();
        $(".mainBox .prev").hide();

        $(".mainBox .main").css("width", (100 * mainLimit) + "%");
        $(".thumbnails").css("width", (100 - 2 * 5) / thumbnailPageSize * thumbnailsLimit + "%");

        // メインに表示する画像
        function showPhoto(n) {
          $main.css("transform", "translateX( -" + (100 / mainLimit * n) + "%)");
          $thumbnailsItems.removeClass("current");
          $thumbnailsItems.eq(n).addClass("current");
          mainCount = n;

          pageCount = Math.floor(n / thumbnailPageSize);
          $thumbnails.css("transform", "translateX( -" + ( pageWidth * pageCount ) + "%)");

          if(mainCount == mainLimit - 1) {
            $(".mainBox .next").hide();
          } else {
            $(".mainBox .next").show();
          }
          if(mainCount == 0) {
            $(".mainBox .prev").hide();
          } else {
            $(".mainBox .prev").show();
          }
          pageNaviSwitch();
        }

        // ページナビの矢印 表示非表示
        function pageNaviSwitch() {
          if (pageCount == 0) {
            $(".thumbnailsBox .prev a").hide();
          } else {
            $(".thumbnailsBox .prev a").show();
          }
          if (pageCount == pageMax -1) {
            $(".thumbnailsBox .next a").hide();
          } else {
            $(".thumbnailsBox .next a").show();
          }
        }


        // メイン画像の矢印
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
          var index = $thumbnailsItems.index(this); // サムネイルがクリックされた番号
          showPhoto(index);
        });

        // サムネイルの矢印
        $(".thumbnailsBox .next").on('click', function() {

          if(pageCount < pageMax -1 ) {
            $thumbnails.css("transform", "translateX( -" + ( pageWidth * ( pageCount + 1) ) + "%)");
            pageCount++;
          }
          pageNaviSwitch();
        });

        $(".thumbnailsBox .prev").on('click', function() {
          if(pageCount > 0 ) {
            $thumbnails.css("transform", "translateX( -" + ( pageWidth * ( pageCount - 1) ) + "%)");
            pageCount--;
          }
          pageNaviSwitch();
        });
      }
      photoGallary();


      if ( ! req.sp ) {
        // PC サイドバ―固定

        var $eventAction = $("#eventAction");
        var $main = $(".eventBody__left");

        $(window).on("load scroll", function() {
          var eventAction_offset_top = $eventAction.offset().top;
          var main_offset_top = $main.offset().top;
          var sub_scroll = main_offset_top + $main.outerHeight(true) - $eventAction.outerHeight(true);
          var ws = $(window).scrollTop();

          if (ws > sub_scroll) {
            $eventAction.css({position:'fixed', top: sub_scroll - ws + 'px'});
          } else if(ws > main_offset_top) {
            $eventAction.css({position:'fixed', top: '0px'});
          } else {
            $eventAction.css({position:'relative', top: '0px'});
          }
        })
      }
      // スマホ
      else {
        // SP 一緒に遊ぶボタン固定
        var $eventActionScroll = $(".eventActionScroll");

        $(window).on("load scroll", function() {
          var scrollHeight = $(document).height();
          var scrollPosition = $(window).outerHeight(true) + $(window).scrollTop();
          var footHeight = $(".contactArea").outerHeight(true) + $("#footer").outerHeight(true);

          // スクロール位置がフッターまで来たら
          if ( scrollHeight - scrollPosition  <= footHeight ) {
            $eventActionScroll.css({position:'absolute', bottom: '0px'});
          } else {
            $eventActionScroll.css({position:'fixed', bottom: '0px'});
          }
        });
      }

      // 「一緒に遊ぶ」クリック時
      $('.participateButton').on('click', function() {
        // ログインしていたら仮予約モーダルを表示
        if ( window.Rails.current_user ) {
          var id = $(this).data('id');
          Modal.open('reservationForm-' + id);
        }
        // ログインしてなかったらログインモーダルを表示
        else {
          Modal.open('loginForm');
        }
      });

      // 「興味あります」クリック時
      $('.interestButton').on('click', function() {
        // ログインしていたら「興味あります」モーダルを表示
        if ( window.Rails.current_user ) {
          Modal.open('interestForm');
        }
        // ログインしてなかったらログインモーダルを表示
        else {
          Modal.open('loginForm');
        }
      });

      // 仮予約フォーム
      $('.reservation_with_share').on('change', function() {
        var checked = $(this).prop('checked');
        var $form = $(this).parents('form');
        var $body = $form.find('textarea');
        $body.prop('disabled', ! checked );
      });

    }
  }
}
