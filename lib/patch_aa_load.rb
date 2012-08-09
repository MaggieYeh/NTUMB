#  https://groups.google.com/forum/?fromgroups#!topic/activeadmin/Uvn3PfrZvp8
ActiveAdmin::Application.class_eval do 
  alias :load_method :load! 

  def load! 
    instance = self # needed for access via closure 
    ActiveSupport.on_load(:after_initialize) do 
      instance.load_method 
    end 
  end 
end 
