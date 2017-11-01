class Parser

  def initialize
  end

  def string_to_ast(string)
    setup(string)
    if valid?
      parse
    else
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
    while @current < @length
      inc
      if space?
        next
      elsif Parser.open_bracket?(current_char)
        list.push(parse)
      elsif Parser.close_bracket?(current_char)
        break
      elsif Parser.bin_op?(current_char)
        list.push(Types::BinOp.new(current_char))
      elsif Parser.numeric?(current_char)
        list.push(current_char.to_i)
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

  def parse_string
    string = ""
    until space?
      string << current_char
      inc
    end
    if Parser.key_word?(string)
      Types::KeyWord.new(string)
    else
      Types::Symbol.new(string)
    end
  end

  def valid?
    i = 0
    @string.chars.each do |n|
      i += 1 if n == "("
      i -= 1 if n == ")"
      return false if i < 0
    end

    true
  end

  def space?
    current_char == " "
  end

  def inc
    @current += 1
  end

  def current_char
    @string[@current]
  end

  class << self
    def numeric?(char)
      /^\d+$/ === char
    end

    def key_word?(char)
      ['def'].include?(char)
    end

    def bin_op?(char)
      ['*', '/', '+', '-', '%'].include?(char)
    end

    def open_bracket?(char)
      ['(', '[', '{'].include?(char)
    end

    def close_bracket?(char)
      [')', ']', '}'].include?(char)
    end
  end
end
