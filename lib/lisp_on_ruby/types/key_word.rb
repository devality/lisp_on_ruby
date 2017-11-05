module Types
  class KeyWord < Types::Base

    attr_reader :value
    def initialize(value)
      @value = value
    end

    def to_s
      value.to_s
    end

    def evaluate(binding_name, binding_value, env)
      case value
      when "def"
        env.define(binding_name.value, binding_value)
        "OK"
      when "return"
        env.get(binding_name.value)
      else
        "Nothing"
      end
    end

    def self.key_word?(word)
      ['def', 'return'].include?(word)
    end
  end
end
