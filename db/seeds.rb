#!/bin/env ruby
# encoding: utf-8

Department::DEPARTMENTS.each do |d|
  Department.find_or_create_by_name(d)
end

AnnounceCategory::CATEGORIES.each do |c|
  AnnounceCategory.find_or_create_by_name(c)
end

Role::ROLES.each do |r|
  Role.find_or_create_by_role(r)
end

Page.descendants.each do |department_page|
  %w[teachers announcements news_reports documents].each do |controller|
    # it will return nil if not found
    unless department_page.delegated.find_by_delegated_to(controller) 
      eval %Q{
        #{controller}_page = #{department_page}.new
        #{controller}_page.delegated_to = "#{controller}"
        #{controller}_page.translation_for(:"zh-TW").menu_title = I18n.t('front_end.#{controller}')
        #{controller}_page.translation_for(:en).menu_title = "#{controller}"
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

if AdminUser.count == 0
  super_admin = AdminUser.new
  super_admin.email = "admin@example.com"
  super_admin.password = "password"
  super_admin.roles << Role.first
  super_admin.save
end
