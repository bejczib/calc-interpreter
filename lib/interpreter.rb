require_relative './token'
class Interpreter

  def initialize(text)
    @text = text
    @pos = 0
    @current_token = nil
  end

  def evaluate
    @current_token = get_next_token
    result = term
    while [Token::PLUS, Token::MINUS].include? @current_token.type
      if @current_token.type == Token::PLUS
        eat(Token::PLUS)
        result += term
      elsif @current_token.type == Token::MINUS
        eat(Token::MINUS)
        result -= term
      end
    end
    result
  end

  private

  def term
    result = factor
    while [Token::MUL, Token::DIV].include? @current_token.type
      if @current_token.type == Token::MUL
        eat(Token::MUL)
        result *= factor
      elsif @current_token.type == Token::DIV
        eat(Token::DIV)
        result /= factor
      end
    end
    result
  end

  def factor
    token = @current_token
    eat(Token::INTEGER)
    token.value.to_i
  end

  def eat(token_type)
    if @current_token.type == token_type
      @current_token = get_next_token
    else
      raise "Zsafol..."
    end
  end

  def get_next_token
    char = @text[@pos]

    return Token.new(Token::EOF,nil) if (@pos > @text.length - 1)
    case
    when is_digit?(char)
      token = Token.new(Token::INTEGER, integer)
      return token
    when char ==  '+'
      token = Token.new(Token::PLUS, @text[@pos])
      @pos += 1
      return token
    when char == '-'
      token = Token.new(Token::MINUS, @text[@pos])
      @pos += 1
      return token
    when char == '*'
      token = Token.new(Token::MUL, @text[@pos])
      @pos += 1
      return token
    when char == '/'
      token = Token.new(Token::DIV, @text[@pos])
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
