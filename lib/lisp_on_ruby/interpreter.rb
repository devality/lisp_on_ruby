class Interpreter

  class << self
    def evaluate(node)
      case node.class.to_s
      when "Abstractions::Pair"
        return node if node.empty?

        head = evaluate(node.car)
        tail = node.cdr

        if head.kind_of?(Types::BinOp)
          eval_bin_op(head, tail)
        else
        end
      else
        node
      end
    end

    def eval_bin_op(op, node)
      return nil if node.empty?

      head = evaluate(node.car)
      tail = node.cdr

      until tail.empty?
        head = real_bin_op(op, head, evaluate(tail.car))
        tail = tail.cdr
      end
      head
    end

    def real_bin_op(op, x, y)
      case op.value
      when "+"
        x + y
      when "-"
        x - y
      when "*"
        x * y
      when "/"
        x / y
      when "%"
        x % y
      else
        nil
      end
    end
  end
end
