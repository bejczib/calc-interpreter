module Utils
  extend self

  def prompt(*args)
    print(*args)
    gets.strip.delete(' ')
  end

end
