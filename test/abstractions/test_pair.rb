require "minitest/autorun"

class TestPair < Minitest::Test
  def setup
    @pair = Pair.new("head", "tail")
  end

  def test_that_pair_has_head
    assert_equal "head", @pair.car
  end

  def test_that_pair_has_tail
    assert_equal "tail", @pair.cdr
  end

  def test_that_pair_is_not_empty
    assert_equal false, @pair.empty?
  end
end
