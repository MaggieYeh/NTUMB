//  http://stackoverflow.com/
//    questions/4086988/how-do-i-make-link-to-open-external-urls-in-a-new-window
$(document).ready(function() {
  $("a").click(function() {
    open_new_window = false;
    link_host = this.href.split("/")[2];
    is_linking_to_admin = !!this.href.split("/")[3].match("admin");
    document_host = document.location.href.split("/")[2];
    is_at_admin = !!document.location.href.split("/")[3].match("admin");

    if (( link_host != document_host ) || 
        ( is_at_admin && !is_linking_to_admin )) {
      open_new_window = true;
    }

    splited_array = this.href.split(".");
    if (splited_array.length > 1) {
      if (this.href.split(".").pop().match(/pdf|jpg|gif|jpeg|png|doc|docx|xls|xlsx/) != null){
        open_new_window = true;
      }
    }

    //if ($(this).hasClass("download")){
      //open_new_window = true;
    //}

    if (open_new_window){
      window.open(this.href);
      return false;
    }
  });
  //$("a[_cke_saved_href |=]").each(function() {
  $("a[_cke_saved_href]").each(function() {
    this.href = $(this).attr("_cke_saved_href");
  });
});
