require "minitest/autorun"

class TestBinOp < Minitest::Test
  def test_that_bin_op_can_add
    assert_equal 8, Types::BinOp.new("+").evaluate(6, 2)
  end

  def test_that_bin_op_can_sub
    assert_equal 4, Types::BinOp.new("-").evaluate(6, 2)
  end

  def test_that_bin_op_can_mul
    assert_equal 12, Types::BinOp.new("*").evaluate(6, 2)
  end

  def test_that_bin_op_can_div
    assert_equal 3, Types::BinOp.new("/").evaluate(6, 2)
  end

  def test_that_bin_op_can_mod
    assert_equal 1, Types::BinOp.new("%").evaluate(7, 2)
  end
end
