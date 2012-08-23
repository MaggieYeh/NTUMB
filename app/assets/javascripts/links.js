//  http://stackoverflow.com/
//    questions/4086988/how-do-i-make-link-to-open-external-urls-in-a-new-window
$(document).ready(function() {
  $("a").click(function() {
    open_new_window = false;
    link_host = this.href.split("/")[2];
    document_host = document.location.href.split("/")[2];
    console.log(link_host,document_host);
    console.log(this.href,document.location.href);

    if (link_host != document_host) {
      open_new_window = true;
    }

    if (this.href.split(".").pop().match(/pdf|jpg|gif|jpeg|png|doc|docx|xls|xlsx/) != null){
      open_new_window = true;
    }

    if (open_new_window){
      window.open(this.href);
      return false;
    }
  });
  $("a[_cke_saved_href |=]").each(function() {
    this.href = $(this).attr("_cke_saved_href");
  });
});
