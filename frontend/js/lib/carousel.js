import $ from 'jquery'

var $mainSlider = $("#mainSlider");
var $slider_ul = $("#mainSlider > ul");
var interval = 3000;
var count_flag = 0;
var transitionClassName = "isTransition";
var limit = $("#mainSlider > ul > li").size();


// 1個増やす
var $firstSlide = $("#mainSlider > ul > li").eq(0).clone();
limit++;
$slider_ul.append($firstSlide).css({width:100*limit + "%"});
$("#mainSlider > ul > li").css({width:100/limit + "%"});


// スライドナビ
var $sliderNavi = $("<div id='sliderNavi'></div>");
var str_li = "";
for(var i = 0; i < limit -1; i++) {
  str_li += "<span></span>";
}
$sliderNavi.append(str_li);
$mainSlider.append($sliderNavi);
$("#sliderNavi > span").eq(0).addClass("current");


// アニメーションのタイマー管理
function startSlider() {
  setTimeout(function() {
    count_flag++;

    if(count_flag >= limit) {
      resetPosition();
    } else {
      animateSlider()

    }

    startSlider();
  }, interval);
}

// アニメーションのリセット管理
function resetPosition() {
  $slider_ul.removeClass(transitionClassName);
  $slider_ul.css("transform","translateX(0%)");
  setTimeout(function(){
    $slider_ul.addClass(transitionClassName);
    count_flag = 1;
    animateSlider();
  }, 20);
}

// アニメーション処理
function animateSlider() {
  var num = Math.floor(10 * (100 / limit * count_flag)) / 10;
  $slider_ul.css("transform","translateX(-" + num + "%)");

  var navi_current = (count_flag >= limit -1) ? 0 : count_flag;
  $("#sliderNavi > span").removeClass("current");
  $("#sliderNavi > span").eq(navi_current).addClass("current");
}

startSlider();
