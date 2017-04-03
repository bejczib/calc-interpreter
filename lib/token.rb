class Token

  INTEGER = 'INTEGER'
  PLUS = 'PLUS'
  MINUS = 'MINUS'
  EOF = 'EOF'

  attr_accessor :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end

end
