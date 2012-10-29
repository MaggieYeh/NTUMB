class TeachersController < ApplicationController

  before_filter :build_nav_list

  def index
    #@teachers = Teacher.page(params[:page])
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
  end

private

  def build_nav_list
    @nav_list = department_page_variable.nav_list_for("teachers")
  end

end
