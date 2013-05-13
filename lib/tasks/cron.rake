# encoding: utf-8
namespace :cron do
  desc "publication"
  task :publication => :environment do
    require 'net/http'
    require 'active_support/core_ext/hash/conversions'
    
    uri = URI("http://ann.cc.ntu.edu.tw/Achv/xmlTeacherData.asp")
    params = {"UnitName" => "管理學院".encode('big5-uao'), "account" => "manage"}
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    teachers = Hash.from_xml(res.body)['TeacherList']['Teacher']
    teachers.each do |hash|
      # puts hash['NTUseq']
      # puts hash['TeacherName']
      # puts hash['UnitName']
      
      teacher = Teacher.find_by_name hash['TeacherName']
      # teacher = Teacher.where(:name => hash['TeacherName'])
      # if teacher.size > 1 不正常
      puts hash['TeacherName'] if teacher.blank?
      next if teacher.blank?
      teacher.update_attributes :ntu_seq => hash['NTUseq']
    end
  end
end