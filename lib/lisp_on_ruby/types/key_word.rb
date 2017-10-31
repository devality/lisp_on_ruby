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
      else
        "Nothing"
      end
    end
  end
end
