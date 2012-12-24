class SubPagesController < ApplicationController
  def show
    @sub_page = SubPage.find(params[:id])
    @parent_page = @sub_page.sub_page_section.page
    @nav_list = ::MyUtils.build_nav_list(@parent_page)
  end
end
