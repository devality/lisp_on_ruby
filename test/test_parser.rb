require "minitest/autorun"

class TestParser < Minitest::Test

  def evaluate(code)
    Interpreter.evaluate(Parser.new.string_to_ast(code), Env.new)
  end

  def test_validation
    assert_equal false, evaluate("(+ 1 3 / 6 3) (+ 5 8))")
    assert_equal false, evaluate("(+ 1 3)(")
  end

  def test_simple_calc
    assert_equal 213, evaluate("(+ -1 202 5 7)")
  end

  def test_nested_calc
    assert_equal 28, evaluate("(+ 10 3 (/ 6 3) (+ 5 8))")
  end

  def test_defining
    assert_equal 42, evaluate("((def abc (* 5 5))
      (+ 2 8 (/ 6 3) (+ 5 abc)))")
  end

  def test_bin_pred
    assert_equal false, evaluate("(>= (/ 8 2) (+ 30 300))")
    assert_equal true, evaluate("(< (* 50 0) 5)")
  end

  def test_strings
    assert_equal 'my (lisp)', evaluate("((def abc 'my (lisp)')(return abc))")
  end

  def test_car
    assert_equal 4, evaluate("(car (cons (+ 2 2) (cons 1 (quote ()))))")
  end

  def test_cdr
    assert_equal 2, evaluate("(car (cdr (cons (+ 2 1) (cons (/ 8 4) (quote ())))))")
  end

  def test_if
    assert_equal "False", evaluate("(if (> 1 2) 1 'False')")
  end

  def test_lambda
    assert_equal 11, evaluate("((lambda (x) (+ x 1)) 10)")
  end

  def test_fibonachi
    assert_equal 610, evaluate("((def fibo (lambda (n) (if (<= n 1) n (+ (fibo (- n 1)) (fibo (- n 2))))))
            (fibo 15))")
  end
end
