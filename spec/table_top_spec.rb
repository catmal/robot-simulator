# frozen_string_literal: true

require 'rspec'
require_relative '../lib/table_top'
RSpec.describe TableTop do
  describe '#valid_position?' do
    it 'returns true for valid positions' do
      table = TableTop.new(5, 5)
      expect(table.valid_position?(2, 3)).to be true
    end

    it 'returns false for positions outside the table' do
      table = TableTop.new(5, 5)
      expect(table.valid_position?(6, 3)).to be false
    end
  end
end
