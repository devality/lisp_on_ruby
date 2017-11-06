module Types
  class Lambda < Types::Base

    attr_reader :args, :body, :env
    def initialize(args, body, env)
      @args = args
      @body = body
      @env = env
    end

    def to_s
      "#{args} #{body}"
    end

    def evaluate(args)
    end
  end
end
