# encoding: utf-8

class MyTruncator
  def self.relax_sanitize(input)
    Sanitize.clean(input, Sanitize::Config::RELAXED)
  end

  def self.my_html_truncator(input_string = "")
    input_string_without_img = MyTruncator.remove_img(input_string)
    HTML_Truncator.truncate(input_string_without_img, 100, :length_in_chars => true)
  end

  def self.preview_truncator(input_string = "")
    paragraphs = Nokogiri::HTML(input_string).css("p")
    chosen_p = ""
    ret = ""
    paragraphs.each do |p|
      next if (p.text.empty? or (p.text.bytesize < 60))
      chosen_p = p.text
      break
    end

    chosen_p.each_char.each_with_object(ret) do |c,r|
      if r.bytesize + c.bytesize > 220
        break
      else
        r << c
      end
    end
    ret
  end

  def self.remove_img(string = "")
    string.gsub(/< *img[^>]*>/,"")
  end
end
