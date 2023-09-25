# frozen_string_literal: true

require 'rspec'
Dir['lib/*'].sort.each { |file| require_relative "../#{file}" }

RSpec.describe 'Robot Simulator Integration Tests' do
  let(:table) { TableTop.new(5, 5) }
  let(:robot) { Robot.new(table) }
  let(:command_parser) { CommandParser.new(robot) }

  def execute_command_and_capture_output(command)
    command_parser.execute_command(command)
    capture_output { robot.report }
  end

  def capture_output
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string.chomp
  ensure
    $stdout = original_stdout
  end

  it 'executes a series of commands and captures the output' do
    expect(execute_command_and_capture_output('PLACE 0,0,NORTH')).to eq('Output: 0,0,NORTH')
    expect(execute_command_and_capture_output('MOVE')).to eq('Output: 0,1,NORTH')
    expect(execute_command_and_capture_output('RIGHT')).to eq('Output: 0,1,EAST')
    expect(execute_command_and_capture_output('LEFT')).to eq('Output: 0,1,NORTH')
  end

  it 'ignores invalid commands' do
    expect(execute_command_and_capture_output('PLACE 0,0,NORTH')).to eq('Output: 0,0,NORTH')
    expect(execute_command_and_capture_output('PLACE 6,6,NORTH')).to eq('Output: 0,0,NORTH')
    expect(execute_command_and_capture_output('LEFT')).to eq('Output: 0,0,WEST')
    expect(execute_command_and_capture_output('MOVE')).to eq('Output: 0,0,WEST')
  end
end
