class Interpreter

  class << self
    def evaluate(node)
      case node.class.to_s
      when "Types::Pair"
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
        head = op.evaluate(head, evaluate(tail.car))
        tail = tail.cdr
      end
      head
    end
  end
end
