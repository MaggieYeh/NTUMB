$(document).ready(function() {
  //active class decorate
  target = decodeURI(document.location.href.split("/").pop());
  selector = "ul.page-nav a[href$='/" + target + "']";
  selector2 = "ul.page-nav a[href$='/" + target + "#']";
  $(selector).parent().addClass('active');
  $(selector2).parent().addClass('active');

  //webkit table cell collapse problem
  var imgs = $("td>img");
  imgs.each(function(index,img){
    var pic_real_width, pic_real_height;
    var thatImgParent = $(img).parent()[0];
    $("<img/>") // Make in memory copy of image to avoid css issues
      .attr("src", $(img).attr("src"))
      .load({ value: thatImgParent },function(event) {
	//console.log(event.data.value);
	event.data.value.width = this.width;   // Note: $(this).width() will not
	event.data.value.height = this.height; // work for in memory images.
      });
  });
  //more webkit problem
  var imgs_under_div = $(".user-input-content img");
  imgs_under_div.each(function(index,img){
    var defined_width = ($(img).attr("width") != undefined);
    var defined_height = ($(img).attr("height") != undefined);
    if (defined_width || defined_height){
      var original_pic_height = $(img).height();
      var original_pic_width = $(img).width();
      var original_ratio = original_pic_height/original_pic_width;
      if(defined_height && defined_width){
	var target_pic_height = $(img).attr("height");
	var target_pic_width = $(img).attr("width");
	$(img).height(target_pic_height);
	$(img).width(target_pic_width);
      }
      else if(defined_width){
	var target_pic_width = $(img).attr("width");
	var target_pic_height = target_pic_width * original_ratio;
	$(img).height(target_pic_height);
	$(img).width(target_pic_width);
      }
      else if(defined_height){
	var target_pic_height = $(img).attr("height");
	var target_pic_width = target_pic_height / original_ratio;
	$(img).height(target_pic_height);
	$(img).width(target_pic_width);
      }
    }
  });

  //setting submenu direction
  $("li.dropdown-submenu").hover(function(){
    var target = $(this).find("ol.dropdown-menu");
    var position = target.offset();
    if ($(window).width() < (position.left + 160) ){
      target.addClass("face-left");
    }
  },function(){
    $(".face-left").removeClass("face-left");
  });
});
