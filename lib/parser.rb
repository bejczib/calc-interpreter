class Parser

  def initialize(lexer)
    @lexer = lexer
    @current_token = @lexer.advance!
  end

  def parse
    expression
  end

  private

  def expression
    node = term
    while [:plus, :minus].include? @current_token.type
      token = @current_token
     if token.type == :plus
       tokenize(:plus)
     elsif token.type == :minus
       tokenize(:minus)
     end
     node = BinOp.new(node, token, term)
    end
    node
  end

  def term
    node = factor
    while [:multiplication, :division].include? @current_token.type
      token = @current_token
      if token.type == :multiplication
        tokenize(:multiplication)
      elsif token.type == :division
        tokenize(:division)
      end
      node = BinOp.new(node, token, factor)
    end
    node
  end

  def factor
    token = @current_token
    if token.type == :plus
      tokenize(:plus)
      UnaryOp.new(token, factor)
    elsif token.type == :minus
      tokenize(:minus)
      UnaryOp.new(token, factor)
    elsif token.type == :integer
      tokenize(:integer)
      Num.new(token)
    elsif token.type == :left_paren
      tokenize(:left_paren)
      node = expression
      tokenize(:rigth_paren)
      node
    end
  end

  def tokenize(token_type)
    if @current_token.type == token_type
      @current_token = @lexer.advance!
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
