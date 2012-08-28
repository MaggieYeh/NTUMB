class AccPage < Page
  def check_department
    if self.department_id.nil?
      #self.department_id = 1
      self.department = Department.find_by_name("Acc")
    end
  end
end
