module Types
  class KeyWord < Types::Base

    attr_reader :value
    def initialize(value)
      @value = value
    end

    def to_s
      value.to_s
    end

    def evaluate(a, b, env)
      case value
      when "def"
        env.define(a.value, b)
        "OK"
      when "quote"
        a
      when "cons"
        if b.kind_of?(Types::Pair)
          Types::Pair.cons(a, b)
        else
          "cons require list"
        end
      when "car"
        if a.kind_of?(Types::Pair)
          a.car
        else
          "car require list"
        end
      when "cdr"
        if a.kind_of?(Types::Pair)
          a.cdr
        else
          "cdr require list"
        end
      when "if", "cond"
        b
      when "return"
        env.get(a.value)
      else
        "Nothing"
      end
    end

    def self.key_word?(word)
      ['def', 'lambda', 'if', 'cond', 'else', 'cons', 'car', 'cdr', 'quote', 'return'].include?(word)
    end
  end
end
