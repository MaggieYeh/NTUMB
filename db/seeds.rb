#!/bin/env ruby
# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#mba,ba,acc,fin,ib,im,emba,gmba?
#college of management,bussiness administration,accounting,finance,international bussiness,information management,mba , Executive mba(master of bussiness adminstration)
  Department.create([{ name: 'Management'},{ name: 'BA'},
                    { name: 'Acc'},{ name: 'Fin'},
                    { name: 'IB'},{ name: 'IM'},
                    { name: 'MBA'}, { name: 'EMBA'}])
  #Department.create([{ name: "管院"},{ name: "工管"},
                    #{ name: "會計"},{ name: "財金"},
                    #{ name: "國企"},{ name: "資管"},
                    #{ name: "MBA"}, { name: "EMBA"}])
