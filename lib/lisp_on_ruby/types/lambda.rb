module Types
  class Lambda < Types::Base

    attr_reader :args, :body
    def initialize(args, body)
      @args = args
      @body = body
    end

    def to_s
      "#{args} #{body}"
    end

    def evaluate(a, b, env)
    end
  end
end
