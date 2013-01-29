class SubPagesController < ApplicationController
  def show
    @sub_page = SubPage.find(params[:id])
  end
end
