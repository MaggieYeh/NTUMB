//  http://stackoverflow.com/
//    questions/4086988/how-do-i-make-link-to-open-external-urls-in-a-new-window
$(document).ready(function() {
  $("a").click(function() {
    link_host = this.href.split("/")[2];
    document_host = document.location.href.split("/")[2];
    console.log(link_host,document_host);
    console.log(this.href,document.location.href);

    if (link_host != document_host) {
      window.open(this.href);
      return false;
    }
  });
});
