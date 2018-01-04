module Nodes

  module Num
    def self.visit(node)
      node.value.include?('.') ? node.value.to_f.round(2) : node.value.to_i
    end
  end

  module BinOp
    def self.visit(node)
      if node.operator.type == :plus
        Interpreter.visit(node.left) + Interpreter.visit(node.right)
      elsif node.operator.type == :minus
        Interpreter.visit(node.left) - Interpreter.visit(node.right)
      elsif node.operator.type == :multiplication
        Interpreter.visit(node.left) * Interpreter.visit(node.right)
      elsif node.operator.type == :division
        Interpreter.visit(node.left) / Interpreter.visit(node.right).to_f
      end
    end
  end

  module UnaryOp
    def self.visit(node)
      if node.operator.type == :plus
        +Interpreter.visit(node.expression)
      elsif node.operator.type == :minus
        -Interpreter.visit(node.expression)
      end
    end
  end
end
