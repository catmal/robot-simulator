# frozen_string_literal: true

require 'rspec'
Dir['lib/*'].sort.each { |file| require_relative "../#{file}" }

RSpec.describe CommandParser do
  describe '#execute_command' do
    let(:table) { TableTop.new(5, 5) }
    let(:robot) { Robot.new(table) }
    let(:command_parser) { CommandParser.new(robot) }

    it 'executes a PLACE command' do
      command_parser.execute_command('PLACE 2,3,NORTH')
      expect(robot.x).to eq(2)
      expect(robot.y).to eq(3)
      expect(robot.facing).to eq('NORTH')
    end

    it 'executes a MOVE command' do
      robot.place(2, 2, 'NORTH')
      command_parser.execute_command('MOVE')
      expect(robot.y).to eq(3)
    end

    it 'executes a LEFT command' do
      robot.place(2, 2, 'NORTH')
      command_parser.execute_command('LEFT')
      expect(robot.facing).to eq('WEST')
    end

    it 'executes a RIGHT command' do
      robot.place(2, 2, 'NORTH')
      command_parser.execute_command('RIGHT')
      expect(robot.facing).to eq('EAST')
    end

    it 'executes a REPORT command' do
      robot.place(2, 2, 'NORTH')
      expect(command_parser.execute_command('REPORT')).to eq('Output: 2,2,NORTH')
    end
  end
end
