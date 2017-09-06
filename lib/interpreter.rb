require_relative './token'
require_relative './lexer'

class Interpreter

  def initialize(lexer)
    @lexer = lexer
    @current_token = @lexer.get_next_token!
  end

  def evaluate
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
      @current_token = @lexer.get_next_token!
    else
      raise "Token type: #{token_type} instead of #{@current_token.type}"
    end
  end
end
