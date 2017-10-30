class Pair

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def self.cons(head, tail)
    Pair.new(head || Pair.new, tail || Pair.new)
  end

  def car
    @head
  end

  def cdr
    @tail
  end

  def empty?
    car.nil? && cdr.nil?
  end
end

