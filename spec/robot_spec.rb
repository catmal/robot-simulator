require 'rspec'
Dir['lib/*'].sort.each { |file| require_relative "../#{file}" }

RSpec.describe Robot do
  let(:table) { TableTop.new(5, 5) }
  let(:robot) { Robot.new(table) }

  describe '#place' do
    it 'places the robot on a valid position' do
      robot.place(2, 3, 'NORTH')
      expect(robot.x).to eq(2)
      expect(robot.y).to eq(3)
      expect(robot.facing).to eq('NORTH')
    end

    it 'does not place the robot on an invalid position' do
      robot.place(6, 3, 'NORTH')
      expect(robot.x).to be_nil
      expect(robot.y).to be_nil
      expect(robot.facing).to be_nil
    end
  end

  describe '#move' do
    it 'moves the robot one unit in the direction it is facing' do
      robot.place(2, 2, 'NORTH')
      robot.move
      expect(robot.x).to eq(2)
      expect(robot.y).to eq(3)
    end

    it 'does not move the robot if it would fall off the table' do
      robot.place(0, 0, 'SOUTH')
      robot.move
      expect(robot.x).to eq(0)
      expect(robot.y).to eq(0)
    end
  end

  describe '#left' do
    it 'rotates when facing north' do
      robot.place(2, 2, 'NORTH')
      robot.left
      expect(robot.facing).to eq('WEST')
    end

    it 'rotates when facing west' do
      robot.place(2, 2, 'WEST')
      robot.left
      expect(robot.facing).to eq('SOUTH')
    end

    it 'rotates when facing south' do
      robot.place(2, 2, 'SOUTH')
      robot.left
      expect(robot.facing).to eq('EAST')
    end

    it 'rotates when facing east' do
      robot.place(2, 2, 'EAST')
      robot.left
      expect(robot.facing).to eq('NORTH')
    end
  end

  describe '#right' do
    it 'rotates when facing north' do
      robot.place(2, 2, 'NORTH')
      robot.right
      expect(robot.facing).to eq('EAST')
    end

    it 'rotates when facing east' do
      robot.place(2, 2, 'EAST')
      robot.right
      expect(robot.facing).to eq('SOUTH')
    end

    it 'rotates when facing south' do
      robot.place(2, 2, 'SOUTH')
      robot.right
      expect(robot.facing).to eq('WEST')
    end

    it 'rotates when facing west' do
      robot.place(2, 2, 'WEST')
      robot.right
      expect(robot.facing).to eq('NORTH')
    end
  end

  describe '#report' do
    it 'reports robot position' do
      robot.place(2, 2, 'NORTH')
      expect(robot.report).to eq('Output: 2,2,NORTH')
    end
  end
end
