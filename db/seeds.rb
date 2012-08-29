#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Department::DEPARTMENTS.each do |d|
  Department.find_or_create_by_name(d)
end

AnnounceCategory::CATEGORIES.each do |c|
  AnnounceCategory.find_or_create_by_name(c)
end

Role::ROLES.each do |r|
  Role.find_or_create_by_role(r)
end



