#require "pry"

word_list = [
  "chicken", "duck", "dog", "cat", "clown",
  "brick", "bananas", "totalitarianism",
  "coffee", "metacircular", "interpreter",
  "wednesday", "ruby", "evaluation", "consternation",
  "chicanery"
]
finished_playing = false
turn_count = 6
answer = word_list.sample

def greeting
  puts "Welcome to the game of Hangman!\n\n"
  puts "I'm not even gonna explain it."
  puts "Just guess letters dummy."
end

def game_over?(turn_count, answer, guesses)
  
  turn_count == 0 || win?(answer,guesses)

end

def show_progress(turn_count, partial_word)
  puts
  puts "The current word is: #{partial_word}"
  puts "You have #{turn_count} guesses left."
end

def prompt_player
  puts
  puts "Please guess a letter: "
  gets.chomp
end

def make_partial(guesses, answer)
  # blank a letter in the answer if it isn't in the guesses
  answer.chars.map do |letter|
    if guesses.include?(letter)
      letter
    else
      "_"
    end
  end
end

def take_turn(turn_count, guesses, answer)
  partial_word = make_partial(guesses, answer).join
  show_progress(turn_count, partial_word)
  prompt_player
end

def win?(answer, guesses)
  answer.chars.all? do |character|
    guesses.include?(character)
  end

  # winner = true
  # answer.chars.each do |letter|
  #   winner = false unless guesses.include?(letter)
  # end
  # winner
end

def postmortem(answer, guesses)
  if win?(answer, guesses)
    puts "Nice work! You win."
  else
    puts "The word was #{answer}. Better luck next time."
  end
end

def hangman(answer, turn_count)
  guesses = []
  greeting

  until game_over?(turn_count,answer,guesses)
    guess = take_turn(turn_count, guesses, answer)
    guesses.push(guess)
    turn_count -= 1 unless answer.include?(guess)
    #binding.pry 
  end
  postmortem(answer, guesses)
  
end

def startplaying(answer,turn_count,word_list)
  finished_playing = false
  until finished_playing
    answer = word_list.sample
    hangman(answer, turn_count)

  puts "Would you like to play again? "
  
    if gets.chomp == "n"
      finished_playing = true
    end  
  end
end

startplaying(answer,turn_count, word_list)

