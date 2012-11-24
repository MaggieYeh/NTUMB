#!/bin/env ruby
# encoding: utf-8

Department::DEPARTMENTS.each do |d|
  Department.find_or_create_by_name(d)
end
Department.find_or_create_by_name(Department::INTERNATIONAL_AFFAIRS)

AnnounceCategory::CATEGORIES.each do |c|
  AnnounceCategory.find_or_create_by_name(c)
end

Role::ROLES.each do |r|
  Role.find_or_create_by_role(r)
end

if TeacherTitle.count == 0
  TeacherTitle::TITLES_en.zip(TeacherTitle::TITLES_zh).each do |t|
    a_title = TeacherTitle.new
    a_title.translation_for(:en).title_name = t[0]
    a_title.translation_for(:"zh-TW").title_name = t[1]
    a_title.save
  end
end
# again it's a one time patch
#TeacherTitle.all.zip(TeacherTitle::TITLES_en) do |t|
  #t[0].translation_for(:en).title_name = t[1]
  #t[0].save
#end

Page.descendants.each do |department_page|
  Page::MODEL_INDEX_PAGES.each do |controller|
    # it will return nil if not found
    unless department_page.delegated.find_by_delegated_to(controller) 
      eval %Q{
        #{controller}_page = #{department_page}.new
        #{controller}_page.delegated_to = "#{controller}"
        #{controller}_page.translation_for(:"zh-TW").menu_title = I18n.t('front_end.#{controller}',:locale => :"zh-TW")
        #{controller}_page.translation_for(:en).menu_title = I18n.t('front_end."#{controller}"',:locale => :en)
        #{controller}_page.url_name = "#{controller}"
        unless #{controller}_page.save
          #{controller}_page.errors.each do |e|
            puts e
          end
        end
      }
    end
  end
end
#below used once and be thrown away to monkey patch records
#Page.descendants.each do |department_page|
  #Page::MODEL_INDEX_PAGES.each do |controller|
    #p = department_page.delegated.find_by_delegated_to(controller)
    #p.translation_for(:en).menu_title = I18n.t("front_end.#{controller}",:locale => :en)
    #p.save
  #end
#end

if AdminUser.count == 0
  super_admin = AdminUser.new
  super_admin.email = "admin@example.com"
  super_admin.password = "password"
  super_admin.roles << Role.first
  super_admin.save
end
