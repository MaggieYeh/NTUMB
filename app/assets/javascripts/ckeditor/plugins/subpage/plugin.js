CKEDITOR.plugins.add('subpage', 
{
  requires: ['iframedialog'],
  init: function(editor) {
    if (editor.id == "cke_1"){
      var sub_page_locale = "zh-TW";
    }
    else {
      var sub_page_locale = "en"; 
    }
    editor.addCommand('subpage', new CKEDITOR.dialogCommand('subpage_'+sub_page_locale)); 
    editor.ui.addButton('subpage', {
	label: '新增內容子頁面',
	command: 'subpage',
	icon: this.path + 'images/subpage.png'
    });
    CKEDITOR.dialog.addIframe('subpage_zh-TW', '新增內容子頁面', 
      'http://' + document.location.host + '/admin/sub_pages/js_new?sub_page_locale=zh-TW' ,
      650, 450, undefined, {buttons: {disabled: true}});
    CKEDITOR.dialog.addIframe('subpage_en', '新增內容子頁面', 
      'http://' + document.location.host + '/admin/sub_pages/js_new?sub_page_locale=en' ,
      650, 450, undefined, {buttons: {disabled: true}});
  },
});

function closedialog(url) {
    CKEDITOR.dialog.getCurrent().hide();
}

function setLink(title,path,locale){
  var target = (locale == "zh-TW") ? "cke_1" : "cke_2"
  for(var prop in CKEDITOR.instances){
    if (CKEDITOR.instances[prop].id == target){
      var editor = CKEDITOR.instances[prop];
      break;
    }
  }
  editor.insertHtml("<a href='" + path + "'>" + title + "</a>");
}

