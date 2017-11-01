require "minitest/autorun"

class TestParser < Minitest::Test
  def setup
    @global_env = Env.new
  end

  def test_simple_calc
    parser = Parser.new
    code = "(+ 1 2)"

    assert_equal 3, Interpreter.evaluate(parser.string_to_ast(code), @global_env)
  end

  def test_nested_calc
    parser = Parser.new
    code = "(+ 1 3 (/ 6 3) (+ 5 8))"

    assert_equal 19, Interpreter.evaluate(parser.string_to_ast(code), @global_env)
  end

  def test_defining
    parser = Parser.new
    code = "((def a (* 5 5))(+ a 2 (/ 6 3) (+ 5 8)))"

    assert_equal 42, Interpreter.evaluate(parser.string_to_ast(code), @global_env)
  end

  def test_validation
    parser = Parser.new
    code = "(+ 1 3 / 6 3) (+ 5 8))"

    assert_equal false, parser.string_to_ast(code)
  end

  def test_recognizing_open_brackets
    assert_equal true, Parser.open_bracket?("(")
    assert_equal true, Parser.open_bracket?("[")
    assert_equal true, Parser.open_bracket?("{")
    assert_equal false, Parser.open_bracket?(")")
  end

  def test_recognizing_close_brackets
    assert_equal true, Parser.close_bracket?(")")
    assert_equal true, Parser.close_bracket?("]")
    assert_equal true, Parser.close_bracket?("}")
    assert_equal false, Parser.close_bracket?("(")
  end
end
