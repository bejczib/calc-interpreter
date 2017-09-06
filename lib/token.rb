class Token

  INTEGER = 'INTEGER'
  PLUS = 'PLUS'
  MINUS = 'MINUS'
  MUL = 'MUL'
  DIV = 'DIV'
  EOF = 'EOF'
  LPAREN = 'LPAREN'
  RPAREN = 'RPAREN'

  attr_accessor :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end

end
