class Lexer

  def initialize(text)
    @text = text
    @pos = 0
  end

  def get_next_token!
    char = @text[@pos]

    return Token.new(Token::EOF,nil) if (@pos > @text.length - 1)
    case char
    when is_digit?
      token = Token.new(Token::INTEGER, integer)
      return token
    when '+'
      token = Token.new(Token::PLUS, @text[@pos])
      @pos += 1
      return token
    when '-'
      token = Token.new(Token::MINUS, @text[@pos])
      @pos += 1
      return token
    when '*'
      token = Token.new(Token::MUL, @text[@pos])
      @pos += 1
      return token
    when '/'
      token = Token.new(Token::DIV, @text[@pos])
      @pos += 1
      return token
    else
      raise "wtf #{char}"
    end
  end

  def integer
    digit = ''
    while is_digit?.call(@text[@pos])
      digit += @text[@pos]
      @pos +=1
    end
    digit
  end

  def is_digit?
    ->(char) { char =~ /[[:digit:]]/ }
  end
end
