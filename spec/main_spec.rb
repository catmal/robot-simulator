require 'rspec'
require 'tempfile'
Dir['lib/*'].sort.each { |file| require_relative "../#{file}" }
describe Main do
  describe '.run' do
    context 'when running with user input' do
      it 'executes PLACE, MOVE, LEFT, RIGHT, REPORT commands correctly' do
        table = TableTop.new(5, 5)
        robot = Robot.new(table)
        command_parser = CommandParser.new(robot)

        input_commands = [
          'PLACE 1,1,NORTH',
          'MOVE',
          'LEFT',
          'RIGHT',
          'REPORT'
        ]

        expected_output = 'Output: 1,2,NORTH'

        input_commands.each do |command|
          command_parser.execute_command(command)
        end

        output = robot.report

        expect(output).to eq(expected_output)
      end
    end

    context 'when running with a temporary file' do
      it 'executes commands from the temporary file correctly' do
        table = TableTop.new(5, 5)
        robot = Robot.new(table)
        command_parser = CommandParser.new(robot)

        # Create a temporary input file with commands
        Tempfile.create(['commands', '.txt']) do |tempfile|
          tempfile.puts 'PLACE 2,2,NORTH'
          tempfile.puts 'MOVE'
          tempfile.puts 'REPORT'
          tempfile.flush

          File.open(tempfile.path, 'r') do |file|
            file.each_line do |line|
              line.chomp!
              command_parser.execute_command(line)
            end
          end

          expected_output = 'Output: 2,3,NORTH'
          output = robot.report

          expect(output).to eq(expected_output)
        end
      end
    end
  end
end
