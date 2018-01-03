module Nodes

  module Num
    def self.visit(node)
      node.value.include?('.') ? node.value.to_f.round(2) : node.value.to_i
    end
  end

  module BinOp
    def self.visit(node)
      if node.operator.type == Token::PLUS
        Interpreter.visit(node.left) + Interpreter.visit(node.right)
      elsif node.operator.type == Token::MINUS
        Interpreter.visit(node.left) - Interpreter.visit(node.right)
      elsif node.operator.type == Token::MUL
        Interpreter.visit(node.left) * Interpreter.visit(node.right)
      elsif node.operator.type == Token::DIV
        Interpreter.visit(node.left) / Interpreter.visit(node.right).to_f
      end
    end
  end

  module UnaryOp
    def self.visit(node)
      if node.operator.type == Token::PLUS
        +Interpreter.visit(node.expression)
      elsif node.operator.type == Token::MINUS
        -Interpreter.visit(node.expression)
      end
    end
  end
end
