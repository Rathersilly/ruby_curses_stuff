class Game
  def collide
    pos = [@ball.row.to_i, @ball.col.to_i]
    
    # Edge case - stop ball from sneaking by literal edge
    if pos[0] == @bar.row
      if pos[1] == 0 && @bar.col == 1
        @ball.col = 1
      elsif pos[1] == Cols - 1 && @bar.col = Cols - 1 - @bar.length
        @ball.col = Cols - 1
      end
    end
    
    # Ball colliding with bar
    if @bar.pixels.include?(pos)
      pix = @bar.image[@ball.col - @bar.col]

      if pix == '1'
        @ball.row -= 1
        @ball.vx = -1.5
        @ball.vy = -1
        @ball.row += @ball.vy
        @ball.col += @ball.vx
      elsif pix == '5'
        @ball.row -= 1
        @ball.vx = 1.5
        @ball.vy = -1
        @ball.row += @ball.vy
        @ball.col += @ball.vx
      elsif pix == '3'
        @ball.row -= 1
        @ball.vy = -@ball.vy
        @ball.row += @ball.vy
        @ball.col += @ball.vx
      end
    end
    xdiff = @ball.col - @ball.prevx
    ydiff = @ball.row - @ball.prevy
    px = @ball.prevx; py = @ball.prevy
    

    # Ball colliding with block
    @blocks.each do |block|
      if struck = block.pixels.index(pos)
        # increase block damage
        block.damage += 1
        if block.damage == 2
          @blocks.delete(block)
        end
        # if leftmost pixel is struck
        if struck == 0
          # if ball came from left
          if xdiff > 0
            # shallow angle
            if xdiff.abs >= ydiff.abs
              @ball.vy = -@ball.vy
            else
              @ball.vx = -@ball.vx
            end
          else
              @ball.vy = -@ball.vy
          end
        # if rightmost pixel is struck
        elsif struck == block.pixels.size - 1
          # if ball came from right
          if xdiff < 0
            # shallow angle
            if xdiff.abs >= ydiff.abs
              @ball.vy = -@ball.vy
            else
              @ball.vx = -@ball.vx
            end
          else
              @ball.vy = -@ball.vy
          end
        else
          @ball.vy = -@ball.vy
        end
      end
    end


    # Ball colliding with border
    if @ball.row == Rows - 1
      @ball.row = Rows - 2
      @ball.vy = -@ball.vy
    elsif @ball.row == 0
      @ball.row = 1
      @ball.vy = -@ball.vy
    end
    if @ball.col >= Cols - 1
      @ball.col = Cols - 2
      @ball.vx = -@ball.vx
    elsif @ball.col <= 0
      @ball.col = 1
      @ball.vx = -@ball.vx
    end
    
    @ball.prevx = @ball.col; @ball.prevy = @ball.row
  end
end
