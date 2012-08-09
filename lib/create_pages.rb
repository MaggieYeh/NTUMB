def register_all_scope(context)
  context.instance_exec do
    Department.all.each do |department|
      ActiveAdmin.register Page.send("#{department.name}"), :as => department.name + " Pages" do
        menu :parent => "Page"
        self.send(:scope, department.name, {:default => true})
      end
    end
  end
end
