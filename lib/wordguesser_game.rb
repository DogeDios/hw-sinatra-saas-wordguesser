class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, 'Invalid guess. Guess cannot be empty.' if letter.nil? || letter.empty?
    raise ArgumentError, 'Invalid guess. Guess must be a single letter.' unless letter.match?(/[a-zA-Z]/)
    letter = letter.downcase
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.include?(letter)
      @guesses << letter
    else
      @wrong_guesses << letter
    end

    true
  end

  def word_with_guesses
    display = @word.chars.map do |char|
      @guesses.include?(char) ? char : '-'
    end
    display.join
  end

  def check_win_or_lose
    return :win if word_guessed?
    return :lose if @wrong_guesses.length >= 7

    :play
  end
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end
  private

  def word_guessed?
    @word.chars.all? { |char| @guesses.include?(char) }
  end
end
