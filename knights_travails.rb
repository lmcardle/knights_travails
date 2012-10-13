
class KnightsTravails
  
  POSSIBLE_MOVES = [[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1]]
  
  def initialize
    @move_history = {}
  end
  
  def play(start_pos, end_pos, *blocked_moves)
    @move_history[start_pos] = nil
    @start_pos = start_pos
    @end_pos = end_pos
    @blocked_moves = blocked_moves
    find_move
  end
  
  def find_move
    levels = 0
    
    while !@move_history.include?(@end_pos)
      if levels > 15
        return nil
      end
      
      expand_moves_by_one
      levels += 1
    end
    found_move
    
  end
  
  def expand_moves_by_one
    p "searching one deeper"
    @move_history.keys.each do |move|
      expand_moves_from_position(move)
    end
  end
  
  def expand_moves_from_position(position)
    POSSIBLE_MOVES.each do |move|
      x = position[0] + move[0]
      y = position[1] + move[1]
      
      new_move = [x,y]
      
      if is_valid_move?(new_move) && is_not_blocked_move?(new_move)
        unless @move_history.keys.include?(new_move)
          @move_history[new_move] = position
        end
      end
    end
  end
  
  def is_valid_move?(position)
    (position[0] >= 0 && position[0] < 8) && (position[1] >= 0 && position[1] < 8)
  end
  
  def is_not_blocked_move?(position)
    !@blocked_moves.include?(position)
  end
  
  def found_move
    @move_history[@start_pos] = nil
    
    found_parent = @end_pos
    found_array = []
    
    while found_parent != nil
      found_array << found_parent
      
      found_parent = @move_history[found_parent]
    end
    found_array.reverse!
  end
end

game = KnightsTravails.new
p game.play([0,7], [5,3], [3,4], [4,5])