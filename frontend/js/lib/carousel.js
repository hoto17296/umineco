import $ from 'jquery'

class Carousel {

  constructor(elem, opts={}) {
    this.$elem = $(elem);
    this.$inner = this.$elem.find('.CarouselInner');
    this.$inner.addClass('isTransition');
    this.$items = this.$elem.find('.CarouselItem');
    this.interval = opts.interval || 5000; // ms
    this.count_flag = 0;
    this.limit = this.$items.size();
    // 初期設定
    this.renderItem();
    this.renderNav();
  }

  // 1個増やす
  renderItem() {
    var $firstSlide = this.$items.first().clone();
    this.limit++;
    this.$inner.append($firstSlide).css({ width: 100 * this.limit + "%" });
    this.$items = this.$elem.find('.CarouselItem');
    this.$items.css({ width: 100 / this.limit + "%" });
  }

  // スライドナビ
  renderNav() {
    this.$navi = $("<div class='CarouselNavi' />");
    var navItems = "";
    for ( var i = 0; i < this.limit-1; i++ ) {
      navItems += "<span />";
    }
    this.$navi.append(navItems);
    this.$elem.append( this.$navi );
    this.$navi.find('span').first().addClass("current");
  }

  // アニメーションスタート
  start() {
    window.setTimeout(() => {
      this.count_flag++;

      if ( this.count_flag >= this.limit ) {
        this.resetPosition();
      } else {
        this.animate()
      }

      this.start();
    }, this.interval);
  }

  // アニメーションのリセット管理
  resetPosition() {
    var transitionClassName = "isTransition";
    this.$inner.removeClass(transitionClassName);
    this.$inner.css("transform", "translateX(0%)");
    window.setTimeout(() => {
      this.$inner.addClass(transitionClassName);
      this.count_flag = 1;
      this.animate();
    }, 0);
  }

  // アニメーション処理
  animate() {
    var num = Math.floor(10 * (100 / this.limit * this.count_flag)) / 10;
    this.$inner.css("transform","translateX(-" + num + "%)");

    var navi_current = (this.count_flag >= this.limit -1) ? 0 : this.count_flag;
    this.$navi.find("span").removeClass("current");
    this.$navi.find("span").eq(navi_current).addClass("current");
  }

}

export default Carousel;
