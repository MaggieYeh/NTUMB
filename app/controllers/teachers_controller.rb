class TeachersController < ApplicationController

  before_filter :build_nav_list

  def index
    #@teachers = Teacher.page(params[:page])
    if @current_department_name == "management"
      @teachers = Teacher.order("front_end_order DESC")
      @departments = Department::DEPARTMENTS.clone # + [Department::INTERNATIONAL_AFFAIRS])
      @departments.shift
    elsif @current_department_name.downcase == "emba" 
      @teachers = Teacher.picked_by_emba.order("front_end_order DESC") + \
                  Teacher.send(@current_department_name).order("front_end_order DESC")
      @departments = Department::DEPARTMENTS.clone # + [Department::INTERNATIONAL_AFFAIRS])
      @departments.shift
    elsif @current_department_name.downcase == "gmba"
      @teachers = Teacher.picked_by_gmba.order("front_end_order DESC") + \
                  Teacher.send(@current_department_name).order("front_end_order DESC")
      @departments = Department::DEPARTMENTS.clone # + [Department::INTERNATIONAL_AFFAIRS])
      @departments.shift
    else
      @teachers = Teacher.send(@current_department_name).order("front_end_order DESC")
      @departments = [@current_department.name]
    end
    @colors = @departments.map{|d| Department::DCOLORS[d]}
    @title_categories = TeacherTitle.all
  end

  def show
    @teacher = Teacher.find(params[:id])
    @seqFound = false
    @color = Department::DCOLORS[@teacher.department.name]
    @use_newweb_data = false
    if @teacher.use_newweb_data
      @use_newweb_data = true
      fetch_newweb_data
    else
      parse_ntu_teacher_publication
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
  end

private

  def fetch_newweb_data
    @paper = @teacher.newweb_teacher_publications.paper.sort_by{|p| p.year}.reverse.map do |paper_node|
                {
                  author: paper_node.author,
                  year: paper_node.year,
                  title: paper_node.title,
                  journal: paper_node.journal_or_conference_orpublisher,
                  remarks: paper_node.other,
                  cate: ""
                }
             end
    @conference_paper = @teacher.newweb_teacher_publications.conference.sort_by{|p| p.year}.reverse.map do |paper_node|
                          {
                            author: paper_node.author,
                            year: paper_node.year,
                            title: paper_node.title,
                            conference: paper_node.journal_or_conference_orpublisher,
                            date: "",
                            location: paper_node.other
                          }
                        end
    @books = @teacher.newweb_teacher_publications.book.sort_by{|p| p.year}.reverse.map do |paper_node|
            {
              author: paper_node.author,
              year: paper_node.year,
              title: paper_node.title,
              remarks: "",
              publisher: paper_node.journal_or_conference_orpublisher,
              book_title: paper_node.other
            }
            end
    @other_publications = @teacher.newweb_teacher_publications.other.sort_by{|p| p.year}.reverse.map do |paper_node|
        {
          author: paper_node.author,
          year: paper_node.year,
          title: paper_node.title,
          remarks: "",
          publisher: paper_node.journal_or_conference_orpublisher,
          book_title: paper_node.other
        }
    end
  end

  def parse_ntu_teacher_publication
    all_xml = Nokogiri::XML(open("http://versatile.management.ntu.edu.tw/publication/all.xml").read)
    teacher_node = all_xml.xpath("//TeacherName").detect do |node| 
                                node.text == @teacher.translation_for("zh-TW").name 
                              end
    unless teacher_node.nil?
      ntuseq = (teacher_node.parent>"NTUseq").text
      @seqFound = true
      paper_xml = Nokogiri::XML( \
        open("http://versatile.management.ntu.edu.tw/publication/journal/#{ntuseq}.xml"))
      @paper = paper_xml.xpath("//Paper").map do |paper_node|
                  {
                    author: (paper_node>"Authors").text,
                    year: (paper_node>"PublishYear").text,
                    title: (paper_node>"PaperTitle").text,
                    journal: (paper_node>"PublishOn").text,
                    remarks: (paper_node>"Remarks").text,
                    cate: ((paper_node>"subgroup")>"group").text
                  }
                end
      conference_xml = Nokogiri::XML( \
        open("http://versatile.management.ntu.edu.tw/publication/conference/#{ntuseq}.xml"))
      @conference_paper = conference_xml.xpath("//Paper").map do |cp_node|
                            {
                              author: (cp_node>"Authors").text,
                              year: (cp_node>"PublishYear").text,
                              title: (cp_node>"PaperTitle").text,
                              conference: (cp_node>"PublishOn").text,
                              date: Date::MONTHNAMES[(cp_node>"PublishMonth").text.to_i],
                              location: (cp_node>"Location").text
                            }
                          end
      books_xml = Nokogiri::XML( \
        open("http://ann.cc.ntu.edu.tw/Achv/xmlBook.asp?Seq=#{ntuseq}"))
      @books = books_xml.xpath("//Book").map do |book_node|
          {
            author: (book_node>"Authors").text,
            year: (book_node>"PublishYear").text,
            title: (book_node>"DocTitle").text,
            remarks: (book_node>"Remarks").text,
            publisher: (book_node>"Publisher").text,
            book_title: (book_node>"BookTitle").text
          }
      end
    end
  end

  def build_nav_list
    @nav_list = department_page_variable.nav_list_for("teachers")
  end

end
