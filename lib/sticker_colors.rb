# encoding: utf-8
class StickerColor
  COLOR_NAMES = %w[藍 紅 綠 紫 淺藍 橘色]
  COLORS = %w[5183c7 c65152 9abb58 8465a7 4daecb ff9748 9a7016 293352 13c29f a2a012 9a7016]
  def self.generate_stikcer_colors(num = 3)
    ret_colors = []
    if num > COLORS.count
      (num / COLORS.count).times{ ret_colors << COLORS.sample(COLORS.count) }
      ret_colors << COLORS.sample(num % COLORS.count)
    else
      ret_colors << COLORS.sample(num)
    end
    ret_colors
  end
end
