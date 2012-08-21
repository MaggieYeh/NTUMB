# encoding: utf-8
#ActiveAdmin.register_page "Document Files" do
  #menu label: "文件檔案", :priority => 20
  #content :title => "文件" do
    #columns do
      #column do
        #panel "文件分類" do
          #ul do
            #DocumentCategory.all.map do |category|
              #li do
                #link_to(category.name, admin_document_category_path(category))
              #end
            #end
          #end
          #span do
            #link_to "新增分類", new_admin_document_category_path
          #end
        #end
      #end
    #end
    #columns do
      #column do
        #panel "最近上傳的文件" do
          #ul do
            #Document.recent(5).map do |document|
              #li link_to(document.discription, admin_document_path(document))
            #end
          #end
          #span do
            #link_to "新增文件", new_admin_document_path
          #end
        #end
      #end
    #end
  #end #content do
#end
