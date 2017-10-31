require "minitest/autorun"

class TestKeyWord < Minitest::Test
  def test_defining_variable
    env = Env.new
    define = Types::KeyWord.new("def")
    a = Types::Symbol.new("a")

    define.evaluate(a, 5, env)

    assert_equal env.get("a"), 5
  end
end
