module Types
  class BinOp < Types::Base

    attr_reader :value
    def initialize(value)
      @value = value
    end

    def to_s
      value.to_s
    end

    def evaluate(x, y)
      case value
      when "+"
        x + y
      when "-"
        x - y
      when "*"
        x * y
      when "/"
        x / y
      when "%"
        x % y
      else
        nil
      end
    end
  end
end
