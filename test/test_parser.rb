require "minitest/autorun"

class TestParser < Minitest::Test
  def setup
    @global_env = Env.new
    @parser = Parser.new
  end

  def test_simple_calc
    code = "(+ 1 202)"

    assert_equal 203, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_nested_calc
    code = "(+ 10 3 (/ 6 3) (+ 5 8))"

    assert_equal 28, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_defining
    code = "((def abc (* 5 5))(+ 2 8 (/ 6 3) (+ 5 abc)))"

    assert_equal 42, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_validation
    code = "(+ 1 3 / 6 3) (+ 5 8))"
    assert_equal false, @parser.string_to_ast(code)

    code = "(+ 1 3)("
    assert_equal false, @parser.string_to_ast(code)
  end
end
