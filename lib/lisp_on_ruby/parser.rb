class Parser

  def initialize
  end

  def string_to_ast(string)
    setup(string)
    if valid?
      parse
    else
      p "Incorrect S-expression"
      false
    end
  end

  private

  def setup(string)
    @string = string
    @length = string.length
    @current = 0
  end

  def parse
    list = []
    until end_of_string?
      go_to_next_char
      if space? || tab? || new_line? || end_of_string?
        next
      elsif open_bracket?
        list.push(parse)
      elsif close_bracket?
        break
      elsif bin_op? && prev_open_bracket?
        list.push(Types::BinOp.new(current_char))
      elsif numeric? || minus?
        list.push(parse_numeric)
      elsif quote?
        list.push(parse_quote_string)
      else
        list.push(parse_string)
      end
    end

    real_list = Types::Pair.new
    while last = list.pop
      real_list = Types::Pair.new(last, real_list)
    end

    real_list
  end

  def parse_numeric
    token = ""
    sign = 1
    if minus?
      sign = -1
      go_to_next_char
    end
    float = false
    while numeric? || dot?
      float = true if dot?
      token << current_char
      go_to_next_char
    end
    go_to_prev_char #to avoid double 'go_to_next_char'

    (float ? token.to_f : token.to_i) * sign
  end

  def parse_string
    token = ""
    until space? || close_bracket? || new_line?
      token << current_char
      go_to_next_char
    end
    go_to_prev_char #to avoid double 'go_to_next_char'

    if key_word?(token)
      Types::KeyWord.new(token)
    elsif bin_pred?(token)
      Types::BinPred.new(token)
    else
      Types::Symbol.new(token)
    end
  end

  def parse_quote_string
    token = ""
    go_to_next_char #skip open quote
    until quote?
      token << current_char
      go_to_next_char #should skip closed quote
    end

    token
  end

  def valid?
    i = 0
    @string.chars.each do |n|
      i += 1 if n == "("
      i -= 1 if n == ")"
      return false if i < 0
    end
    return false if i != 0

    true
  end

  def end_of_string?
    @current >= @length
  end

  def go_to_next_char
    @current += 1
  end

  def go_to_prev_char
    @current -=1
  end

  def current_char
    @string[@current]
  end

  def previous_char
    @string[@current - 1]
  end

  def numeric?
    /^\d+$/ === current_char
  end

  def minus?
    current_char == '-'
  end

  def key_word?(token)
    Types::KeyWord.key_word?(token)
  end

  def quote?
    ['"', "'"].include?(current_char)
  end

  def bin_op?
    Types::BinOp.bin_op?(current_char)
  end

  def bin_pred?(token)
    Types::BinPred.bin_pred?(token)
  end

  def space?
    current_char == " "
  end

  def tab?
    current_char == "\t"
  end

  def dot?
    current_char == "."
  end

  def new_line?
    ["\n", "\r"].include?(current_char)
  end

  def open_bracket?
    current_char == "("
  end

  def prev_open_bracket?
    previous_char == "("
  end

  def close_bracket?
    current_char == ")"
  end
end
