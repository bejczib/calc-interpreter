require_relative './token'

class Interpreter

  def initialize(text)
    @text = text
    @pos = 0
    @current_token = nil
  end

  def evaluate
    result = ''
    @current_token = get_next_token
    @text.split('').each do |char|
      result += @current_token.value unless @current_token.value.nil?
      @current_token = get_next_token
    end
    return eval(result)
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
    digit
  end
end
