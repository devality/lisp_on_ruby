class Parser

  def initialize
  end

  def string_to_ast(string)
    setup(string)
    valid? ? parse : false
  end

  private

  def setup(string)
    @string = string
    @length = string.length
    @current = 0
  end

  def parse
    list = []
    while @current < @length
      next_char
      if space?
        next
      elsif open_bracket?
        list.push(parse)
      elsif close_bracket?
        break
      elsif bin_op?
        list.push(Types::BinOp.new(current_char))
      elsif numeric?
        list.push(parse_numeric)
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
    while numeric?
      token << current_char
      next_char
    end
    prev_char
    token.to_i
  end

  def parse_string
    token = ""
    until space? || close_bracket?
      token << current_char
      next_char
    end
    prev_char
    if key_word?(token)
      Types::KeyWord.new(token)
    else
      Types::Symbol.new(token)
    end
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

  def next_char
    @current += 1
  end

  def prev_char
    @current -=1
  end

  def current_char
    @string[@current]
  end

  def numeric?
    /^\d+$/ === current_char
  end

  def key_word?(token)
    ['def'].include?(token)
  end

  def bin_op?
    ['*', '/', '+', '-', '%'].include?(current_char)
  end

  def open_bracket?
    current_char == "("
  end

  def space?
    current_char == " "
  end

  def close_bracket?
    current_char == ")"
  end
end
