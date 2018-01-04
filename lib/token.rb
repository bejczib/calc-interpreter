class Token

  CONFIG = {
    integer: 'integer',
    plus: '+',
    minus: '-',
    multiplication: '*',
    division: '/',
    eof: 'eof',
    left_paren: '(',
    rigth_paren: ')',
}

  attr_accessor :type, :value

  def initialize(type, value)
    @type = type
    @value = value
  end

end
