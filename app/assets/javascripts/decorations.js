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
});
