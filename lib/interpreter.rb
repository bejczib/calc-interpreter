require_relative './token'

class Interpreter

  def initialize(text)
    @text = text
    @pos = 0
    @current_token = nil
  end

  def evaluate
    @current_token = get_next_token

    left = @current_token.value
    @current_token = get_next_token

    operator = @current_token.value
    @current_token = get_next_token

    right = @current_token.value
    @current_token = get_next_token

    return eval("#{left}#{operator}#{right}")

  end

  private

  def get_next_token
    char = @text[@pos]

    return Token.new(Token::EOF,nil) if (@pos > @text.length - 1)
    case
    when is_digit?(char)
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
    else
      raise "wtf #{char}"
    end
  end

  def is_digit?(char)
    char =~ /[[:digit:]]/
  end

  def integer
    digit = ''
    while is_digit?(@text[@pos])
      digit += @text[@pos]
      @pos +=1
    end
    digit.to_i
  end
end
