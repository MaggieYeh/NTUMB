# http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html
if Rails.env.development?
  %w[acc_page ib_page im_page gmba_page emba_page ba_page management_page fin_page].each do |c|
    require_dependency File.join("app","models","department_page","#{c}.rb")
  end
end
