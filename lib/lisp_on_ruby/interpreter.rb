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
        when 'Types::BinPred'
          eval_bin_pred(head, tail, env)
        when 'Types::KeyWord'

          case head.value
          when "if"
            eval_if(head, tail, env)
          when "cons", "car", "cdr"
            head.evaluate(evaluate(tail.car, env), evaluate(tail.cdr.car, env), env)
          when "lambda"
            Types::Lambda.new(tail.car, tail.cdr.car, env)
          else
            head.evaluate(tail.car, evaluate(tail.cdr.car, env), env)
          end

        when 'Types::Lambda'
          sub_env = Env.new({}, env)
          bind_lambda_args(sub_env, head.args, tail, env)
          evaluate(head.body, sub_env)
        else
          evaluate(tail.car, env)
        end
      when 'Types::Symbol'
        env.get(node.value)
      else
        node
      end
    end

    def bind_lambda_args(sub_env, args, tail, env)
      return if args.empty? || tail.empty?

      arg = args.car
      value = evaluate(tail.car, env)
      sub_env.define(arg.value, value)

      bind_lambda_args(sub_env, args.cdr, tail.cdr, env)
    end

    def eval_if(head, tail, env)
      predicat = evaluate(tail.car, env)
      if predicat
        head.evaluate(predicat, evaluate(tail.cdr.car, env), env)
      else
        head.evaluate(predicat, evaluate(tail.cdr.cdr.car, env), env)
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

    def eval_bin_pred(op, node, env)
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
