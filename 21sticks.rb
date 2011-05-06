class Game
  def initialize(name)
    @name = name
    @total = 21
    play_game
  end
  
  def choose_first_player
    pool = [1,2,3,4,5,6,7,8,9,10]
	pick_num = pool[rand(pool.length)]
	if pick_num.modulo(2) == 0 
	  @player_turn = true 
	  @character = "player"
	else
	  @player_turn = false
	  @character = "computer"
	end
	puts "\nThe #{@character} was randomly selected to go first.\n"
  end
  
  def get_computer_number
    choices = [1, 2, 3, 4]
	if @total <= 4
	  pick = @total
	elsif @total.modulo(5) != 0
	  pick = @total.modulo(5)
	else
      pick = choices[rand(choices.length)]
	end
    return pick
  end
  
  def end_of_game?
    @total == 0 ? true : false
  end

  def get_player_number
    print "\n#{@name}, how many sticks would you like to remove? (1-4) "
    s = gets.chomp!.to_i
  end

  def play_game
    choose_first_player
    while not end_of_game?
	  if @player_turn
        player_pick = get_player_number
        if player_pick >= 1 && player_pick <= 4
          if valid_pick?(player_pick)
            @total -= player_pick
            puts "You chose #{player_pick} #{plural!(player_pick)}. #{@total} #{plural!(@total)} remaining."
            end_of_game? ? puts("Congratulations, you win!") : @player_turn = false
          else
            puts "There are not that many sticks left. #{@total} sticks left."
          end
        else
          puts "\nYou chose an invalid number. Please pick again."
        end
      else  #computer turn
        computer_pick = get_computer_number
        @total -= computer_pick
        puts "Computer chose #{computer_pick} #{plural!(computer_pick)}. #{@total} #{plural!(@total)} remaining."
        end_of_game? ? puts("So sorry, computer wins. Better luck next time.") : @player_turn = true
      end
    end
  end

  def plural!(number)
    number != 1 ? "sticks" : "stick"
  end

  def valid_pick?(pick)
    pick > @total ? false : true
  end

end

response = ""
print "Hello, welcome to the game 21sticks. What is your name? "
name = gets.chomp!
while response != 'q'
  print "\nHello again #{name}, ready to play (y n)? To quit, press Q. "
  response = gets.chomp.downcase
  if response == 'n'
    puts "Sleeping..."
    sleep 5
  elsif response == 'y'
    game = Game.new(name)
  elsif response == 'q'
    puts "\nAwe sorry to see you go so soon, #{name}. See you next time.\n"
  else
    puts "Invalid response. Quit trying to be Kevin Mitnick and just play the damn game!\n"  
  end
end