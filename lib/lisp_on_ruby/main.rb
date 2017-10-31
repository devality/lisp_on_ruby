class Main
  def self.test
    add = Types::BinOp.new("+")
    sub = Types::BinOp.new("-")
    mul = Types::BinOp.new("*")
    div = Types::BinOp.new("/")

    list = self.cons(div, self.cons(self.cons(mul, self.cons(5, self.cons(3, nil))), self.cons(3, nil)))
    p Printer.show(list)

    p Interpreter.evaluate(list)
  end

  def self.cons(head, tail)
    Types::Pair.cons(head, tail)
  end
end
