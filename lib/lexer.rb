class Lexer

  def initialize(text)
    @text = text
    @pos = 0
  end

  def advance!
    char = @text[@pos]

    return Token.new(:eof,nil) if (@pos > @text.length - 1)

    if is_digit? char
      Token.new(:integer, integer)
    else
      token = Token.new(token_type_for(char), @text[@pos])
      @pos += 1
      return token
    end
  end

  private

  def token_type_for(char)
    validate! char
    Token::CONFIG.select { |k,v| v == char }.keys.first
  end

  def validate!(char)
    raise "Invalid type for #{char}" if Token::CONFIG.select { |k,v| v == char }.keys.empty?
  end

  def integer
    digit = ''
    while is_digit?(@text[@pos]) or @text[@pos] == '.'
      digit += @text[@pos]
      @pos +=1
    end
    digit
  end

  def is_digit?(char)
    char =~ /[[:digit:]]/
  end
end
