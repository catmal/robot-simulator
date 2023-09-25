Dir['lib/*'].sort.each { |file| require_relative "../#{file}" }

class Main
  def self.run(file_path = nil)
    table = TableTop.new(5, 5)
    robot = Robot.new(table)
    command_parser = CommandParser.new(robot)

    if file_path.nil?
      while (line = gets)
        line.chomp!
        command_parser.execute_command(line)
      end
    else
      File.open(file_path, 'r') do |file|
        file.each_line do |line|
          line.chomp!
          command_parser.execute_command(line)
        end
      end
    end
  end
end
