class PagesController < ApplicationController
  def view
    department = Page.send(params[:dname])
    @page = department.find_by_path("/#{params[:path]}")
    #binding.pry
  end

private

  def create_menu
    
  end
end
