class Interpreter

  class << self
    def evaluate(node, env)
      case node.class.to_s
      when "Types::Pair"
        return node if node.empty?

        head = evaluate(node.car, env)
        tail = node.cdr

        case head.class.to_s
        when 'Types::BinOp'
          eval_bin_op(head, tail, env)
        when 'Types::KeyWord'
          head.evaluate(tail.car, evaluate(tail.cdr.car, env), env)
        else
          evaluate(tail.car, env)
        end
      when 'Types::Symbol'
        env.get(node.value)
      else
        node
      end
    end

    def eval_bin_op(op, node, env)
      return nil if node.empty?

      head = evaluate(node.car, env)
      tail = node.cdr

      until tail.empty?
        head = op.evaluate(head, evaluate(tail.car, env))
        tail = tail.cdr
      end
      head
    end
  end
end
