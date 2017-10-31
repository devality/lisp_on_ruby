require "minitest/autorun"

class TestInterpreter < Minitest::Test
  def test_that_interpreter_eval_list
    mul = Types::BinOp.new("*")
    div = Types::BinOp.new("/")

    pair_3 = Types::Pair.cons(3, nil)
    mul_3_5 = Types::Pair.cons(mul, Types::Pair.cons(5, pair_3))
    div = Types::Pair.cons(div, Types::Pair.cons(mul_3_5, pair_3))

    assert_equal 5, Interpreter.evaluate(div)
  end
end
