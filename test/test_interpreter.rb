require "minitest/autorun"

class TestInterpreter < Minitest::Test
  def test_calculating
    global_env = Env.new

    mul = Types::BinOp.new("*")
    div = Types::BinOp.new("/")

    pair_3 = Types::Pair.cons(3, nil)
    mul_3_5 = Types::Pair.cons(mul, Types::Pair.cons(5, pair_3))
    list = Types::Pair.cons(div, Types::Pair.cons(mul_3_5, pair_3))

    assert_equal 5, Interpreter.evaluate(list, global_env)
  end

  def test_variable_defining
    global_env = Env.new

    define = Types::KeyWord.new("def")
    mul = Types::BinOp.new("*")
    a = Types::Symbol.new("a")

    pair_3 = Types::Pair.cons(3, nil)
    list = Types::Pair.cons(define, Types::Pair.cons(a, pair_3))

    assert_equal "OK", Interpreter.evaluate(list, global_env)

    list = Types::Pair.cons(mul, Types::Pair.cons(a, pair_3))
    assert_equal 9, Interpreter.evaluate(list, global_env)
  end
end
