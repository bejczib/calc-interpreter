require_relative './token'
require_relative './lexer'
require_relative './nodes'
require_relative './utils'

class Interpreter

  def initialize(parser)
    @parser = parser
  end

  def call
    self.class.visit(@parser.parse)
  end

  private

  def self.visit(ast)
    begin
      Nodes.const_get(ast.class.to_s).visit(ast)
    rescue Exception => ex
      puts ex
    end
  end
end
