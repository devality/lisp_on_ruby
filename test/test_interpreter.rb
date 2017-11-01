require "minitest/autorun"

class TestInterpreter < Minitest::Test
  def setup
    @global_env = Env.new

    @define = Types::KeyWord.new("def")
    @a = Types::Symbol.new("a")

    @add = Types::BinOp.new("+")
    @mul = Types::BinOp.new("*")
    @div = Types::BinOp.new("/")
  end

  def test_calculating
    pair_3 = Types::Pair.cons(3, nil)
    mul_3_5 = Types::Pair.cons(@mul, Types::Pair.cons(5, pair_3))
    list = Types::Pair.cons(@div, Types::Pair.cons(mul_3_5, pair_3))

    assert_equal 5, Interpreter.evaluate(list, @global_env)
  end

  def test_variable_defining
    numbers = Types::Pair.cons(1, Types::Pair.cons(2, Types::Pair.cons(3, nil)))
    list = Types::Pair.cons(@define, Types::Pair.cons(@a, Types::Pair.cons(Types::Pair.cons(@add, numbers), nil)))

    assert_equal "OK", Interpreter.evaluate(list, @global_env)

    list = Types::Pair.cons(@mul, Types::Pair.cons(@a, numbers))

    assert_equal 36, Interpreter.evaluate(list, @global_env)
  end
end
