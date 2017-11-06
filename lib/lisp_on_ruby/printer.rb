class Printer
  class << self
    def print(node)
      p node_to_s(node)
    end

    private
    def list_to_s(node)
      node_to_s(node.car) + (node.cdr.empty? ? "" : " " + list_to_s(node.cdr))
    end

    def node_to_s(node)
      case node.class.to_s
      when "Fixnum"
        node.to_s
      when "String"
        "\"#{node}\""
      when "Types::Symbol"
        node.to_s
      when "Types::KeyWord"
        node.to_s
      when "Types::BinOp"
        node.to_s
      when "Types::Lambda"
        "(lambda #{self.node_to_s(node.args)} #{self.node_to_s(node.body)})"
      when "Types::BinPred"
        node.to_s
      when "Types::Pair"
        unless node.empty?
          "(#{list_to_s(node)})"
        else
          "()"
        end
      when "NilClass"
        ""
      else
        "not_found"
      end
    end
  end
end
