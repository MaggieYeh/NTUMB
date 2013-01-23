# encoding: utf-8
namespace :my_db_seed do
  desc "For my own database seeds"

  task :test_using do
    puts "hi!"
  end

  task :home_page_config => :environment do
    Department.all.each do |department|
      if HomePageConfig.find_by_department_id(department.id).nil?
        h = HomePageConfig.new
        h.department = department
        h.contact_info = "manager@management.ntu.edu.tw"
        h.save
        4.times do |i|
          tab = HomePageTabField.new
          tab.visible = true
          tab.home_page_config = h
          if i == 0
            tab.translation_for(:"zh-TW").first_name = "即時"
            tab.translation_for(:"zh-TW").last_name = "訊息"
            tab.translation_for(:en).first_name = "News"
            tab.announce_categories = AnnounceCategory.all
          elsif i == 1
            tab.translation_for(:"zh-TW").first_name = "管院"
            tab.translation_for(:"zh-TW").last_name = "頻道"
            tab.translation_for(:en).first_name = "Channel"
            tab.youtube_channel_account = "NTUManagement"
          elsif i == 2
            tab.translation_for(:"zh-TW").first_name = "院系"
            tab.translation_for(:"zh-TW").last_name = "徵才"
            tab.translation_for(:en).first_name = "Recruit"
            tab.announce_categories = [AnnounceCategory.find_by_name("intern_opportunities"),
                                       AnnounceCategory.find_by_name("enrollments")]
          elsif i == 3
            tab.translation_for(:"zh-TW").first_name = "學生"
            tab.translation_for(:"zh-TW").last_name = "專區"
            tab.translation_for(:en).first_name = "Student"
            tab.announce_categories = [AnnounceCategory.find_by_name("scholarship_and_exchange_student"),
                                       AnnounceCategory.find_by_name("enrollments")]
          end
          tab.save
        end # 4.times
      end # if HomePageConfig
    end # Department.all
  end # task :home_page_config

end
