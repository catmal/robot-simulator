# frozen_string_literal: true

class CommandParser
  def initialize(robot)
    @robot = robot
  end

  def execute_command(command)
    case command
    when /^PLACE (\d+),(\d+),(NORTH|SOUTH|EAST|WEST)$/
      x = ::Regexp.last_match(1).to_i
      y = ::Regexp.last_match(2).to_i
      facing = ::Regexp.last_match(3)
      @robot.place(x, y, facing)
    when 'MOVE'
      @robot.move
    when 'LEFT'
      @robot.left
    when 'RIGHT'
      @robot.right
    when 'REPORT'
      @robot.report
    end
  end
end
