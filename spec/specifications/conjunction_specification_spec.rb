require 'spec_helper'
require_relative '../../app/models/container'
require_relative '../../app/specifications/specification'
require_relative '../../app/specifications/maximum_temperature_specification'
require_relative '../../app/specifications/sanitary_for_food_specification'
require_relative '../../app/specifications/conjunction_specification'

describe ConjunctionSpecification do
  let(:spec) { described_class.new(components) }
  let(:components) do
    [
      MaximumTemperatureSpecification.new(-4),
      SanitaryForFoodSpecification.new
    ]
  end

  let(:container) do
    Container.new(
      maintainbable_temperatures: -5...5,
      is_sanitary_for_food: true
    )
  end

  it { expect(spec.is_satisfied_by?(container)).to be true }

  context 'when cant maintain temperature' do
    let(:container) do
      Container.new(
        maintainbable_temperatures: -3...5,
        is_sanitary_for_food: true
      )
    end
    it { expect(spec.is_satisfied_by?(container)).to be false }
  end

  context 'when not sanitary for food' do
    let(:container) do
      Container.new(
        maintainbable_temperatures: -5...5,
        is_sanitary_for_food: false
      )
    end
    it { expect(spec.is_satisfied_by?(container)).to be false }
  end
end
