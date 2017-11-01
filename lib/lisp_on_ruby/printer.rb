class Printer
  class << self
    def print(node)
      p node_to_s(node)
    end

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
      when "Types::Pair"
        "(#{list_to_s(node)})"
      when "NilClass"
        ""
      else
        "not_found"
      end
    end
  end
end
