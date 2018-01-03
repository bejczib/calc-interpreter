class Parser

  def initialize(lexer)
    @lexer = lexer
    @current_token = @lexer.get_next_token!
  end

  def parse
    expression
  end

  private

  def expression
    node = term
    while [Token::PLUS, Token::MINUS].include? @current_token.type
      token = @current_token
     if token.type == Token::PLUS
       tokenize(Token::PLUS)
     elsif token.type == Token::MINUS
       tokenize(Token::MINUS)
     end
     node = BinOp.new(node, token, term)
    end
    node
  end

  def term
    node = factor
    while [Token::MUL, Token::DIV].include? @current_token.type
      token = @current_token
      if token.type == Token::MUL
        tokenize(Token::MUL)
      elsif token.type == Token::DIV
        tokenize(Token::DIV)
      end
      node = BinOp.new(node, token, factor)
    end
    node
  end

  def factor
    token = @current_token
    if token.type == Token::PLUS
      tokenize(Token::PLUS)
      UnaryOp.new(token, factor)
    elsif token.type == Token::MINUS
      tokenize(Token::MINUS)
      UnaryOp.new(token, factor)
    elsif token.type == Token::INTEGER
      tokenize(Token::INTEGER)
      Num.new(token)
    elsif token.type == Token::LPAREN
      tokenize(Token::LPAREN)
      node = expression
      tokenize(Token::RPAREN)
      node
    end
  end

  def tokenize(token_type)
    if @current_token.type == token_type
      @current_token = @lexer.get_next_token!
    else
      raise "Token type: #{token_type} instead of #{@current_token.type}"
    end
  end

end

class BinOp
  attr_reader :left, :operator, :right
  def initialize(left, operator, right)
    @left = left
    @operator = operator
    @right = right
  end
end


class Num
  attr_reader :value
  def initialize(token)
    @token = token
    @value = @token.value
  end
end

class UnaryOp
  attr_reader :operator, :expression
  def initialize(operator, expression)
    @operator = operator
    @expression = expression
  end
end
