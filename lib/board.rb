require "byebug"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14) {[]}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, cup_idx|
      unless cup_idx == 6 || cup_idx == 13
        4.times do
          cup << :stone
        end
      end
    end

  end

  def valid_move?(start_pos)
    if start_pos <= 0 || start_pos > 14
      raise "Invalid starting cup"
    end

  end
  
  def make_move(start_pos, current_player_name)
    if current_player_name == @player2
      skip_pos = 6
      points_cup = 13
    else
      skip_pos = 13
      points_cup = 6
    end
    #debugger
    stones = cups[start_pos].length
    cups[start_pos] = []
    next_pos = start_pos + 1
    until stones == 0
      if next_pos != skip_pos
        cups[next_pos] << :stone
        stones = stones - 1
      end
        next_pos += 1
        if next_pos == 14
          next_pos = 0
        end
    end

    render
    next_move = next_turn(next_pos-1)

    if next_pos = points_cup
      return next_pos-1
    elsif next_move == :prompt
      return :prompt
    elsif next_pos == 13
      return :prompt
    end

  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move

    if @cups[ending_cup_idx].length == 0 ||
      :switch
    else
      :prompt
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def cups_empty?
    your_cups = @cups.take(6).none?
    my_cups = @cups[7..12].none?
    if your_cups || my_cups
      return true
    end
    false
  end

  def winner
    if @cups[6].length == @cups[13].length
      :draw
    elsif @cups[6].length > @cups[13].length
      @player1
    else
      @player2
    end

  end
end
