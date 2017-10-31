class Printer
  class << self
    def show_list(node)
      show(node.car) + (node.cdr.empty? ? "" : " " + show_list(node.cdr))
    end

    def show(node)
      case node.class.to_s
      when "Fixnum"
        node.to_s
      when "String"
        "\"#{node}\""
      when "Types::Symbol"
        node.to_s
      when "Types::BinOp"
        node.to_s
      when "Abstractions::Pair"
        "(#{show_list(node)})"
      when "NilClass"
        ""
      else
        "not_found"
      end
    end
  end
end
