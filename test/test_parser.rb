require "minitest/autorun"

class TestParser < Minitest::Test
  def setup
    @global_env = Env.new
    @parser = Parser.new
  end

  def test_simple_calc
    code = "(+ 1 202 5 7)"

    assert_equal 215, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_nested_calc
    code = "(+ 10 3 (/ 6 3) (+ 5 8))"

    assert_equal 28, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_defining
    code = "((def abc (* 5 5))
    (+ 2 8 (/ 6 3) (+ 5 abc)))"

    assert_equal 42, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_bin_pred
    code = "(>= (/ 8 2) (+ 30 300))"
    assert_equal false, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)

    code = "(< (* 50 0) 5)"
    assert_equal true, Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_strings
    code = "((def abc 'my lisp')(return abc))"
    assert_equal 'my lisp', Interpreter.evaluate(@parser.string_to_ast(code), @global_env)

    code = '((def abc "my (lisp)")(return abc))'
    assert_equal "my (lisp)", Interpreter.evaluate(@parser.string_to_ast(code), @global_env)
  end

  def test_car
    code = "(car (cons (+ 2 2) (cons 1 (quote ()))))"
    ast = @parser.string_to_ast(code)
    assert_equal 4, Interpreter.evaluate(ast, @global_env)
  end

  def test_cdr
    code = "(car (cdr (cons (+ 2 1) (cons (/ 8 4) (quote ())))))"
    ast = @parser.string_to_ast(code)
    assert_equal 2, Interpreter.evaluate(ast, @global_env)
  end

  def test_quote
    code = "(+ (cdr (quote (1 2 3 4 5))))"
    ast = @parser.string_to_ast(code)
    # Printer.print(Interpreter.evaluate(ast, @global_env))
    # assert_equal 14, Interpreter.evaluate(ast, @global_env)
  end

  def test_if
    code = "(if (> 1 2) 1 'False')"
    ast = @parser.string_to_ast(code)
    assert_equal "False", Interpreter.evaluate(ast, @global_env)
  end

  def test_validation
    code = "(+ 1 3 / 6 3) (+ 5 8))"
    assert_equal false, @parser.string_to_ast(code)

    code = "(+ 1 3)("
    assert_equal false, @parser.string_to_ast(code)
  end
end
