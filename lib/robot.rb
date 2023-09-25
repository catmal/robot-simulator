# frozen_string_literal: true

class Robot
  attr_reader :x, :y, :facing

  def initialize(table)
    @table = table
    @x = nil
    @y = nil
    @facing = nil
  end

  def place(x, y, facing)
    return unless @table.valid_position?(x, y) && %w[NORTH SOUTH EAST WEST].include?(facing)

    @x = x
    @y = y
    @facing = facing
  end

  def move
    return unless placed?

    case @facing
    when 'NORTH'
      @y += 1 if @table.valid_position?(@x, @y + 1)
    when 'SOUTH'
      @y -= 1 if @table.valid_position?(@x, @y - 1)
    when 'EAST'
      @x += 1 if @table.valid_position?(@x + 1, @y)
    when 'WEST'
      @x -= 1 if @table.valid_position?(@x - 1, @y)
    end
  end

  def left
    return unless placed?

    case @facing
    when 'NORTH' then @facing = 'WEST'
    when 'SOUTH' then @facing = 'EAST'
    when 'EAST' then @facing = 'NORTH'
    when 'WEST' then @facing = 'SOUTH'
    end
  end

  def right
    return unless placed?

    case @facing
    when 'NORTH' then @facing = 'EAST'
    when 'SOUTH' then @facing = 'WEST'
    when 'EAST' then @facing = 'SOUTH'
    when 'WEST' then @facing = 'NORTH'
    end
  end

  def report
    return unless placed?

    output = "Output: #{@x},#{@y},#{@facing}"
    puts output
    output
  end

  private

  def placed?
    !@x.nil? && !@y.nil? && !@facing.nil?
  end
end
