class TeachersController < ApplicationController
  def index
    @teachers = Teacher.page(params[:page])
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
end
