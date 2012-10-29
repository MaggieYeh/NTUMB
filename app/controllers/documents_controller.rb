class DocumentsController < ApplicationController

  before_filter :build_nav_list

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

private

  def build_nav_list
    @nav_list = department_page_variable.nav_list_for("documents")
  end

end
