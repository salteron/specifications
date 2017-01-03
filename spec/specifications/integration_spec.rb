require 'spec_helper'
require_relative '../../app/specifications/specification'
require_relative '../../app/specifications/conjunction_specification'
require_relative '../../app/specifications/negation_specification'
require_relative '../../app/specifications/sanitary_for_food_specification'
require_relative '../../app/specifications/maximum_temperature_specification'
require_relative '../../app/models/container'

describe '#and' do
  let(:spec) do
    SanitaryForFoodSpecification.new.and(
      MaximumTemperatureSpecification.new(-4)
    )
  end

  let(:container) do
    Container.new(
      maintainbable_temperatures: -5...5,
      is_sanitary_for_food: true
    )
  end

  it { expect(spec.satisfied_by?(container)).to be true }

  context 'when cant maintain temperature' do
    let(:container) do
      Container.new(
        maintainbable_temperatures: -3...5,
        is_sanitary_for_food: true
      )
    end
    it { expect(spec.satisfied_by?(container)).to be false }
  end

  context 'when not sanitary for food' do
    let(:container) do
      Container.new(
        maintainbable_temperatures: -5...5,
        is_sanitary_for_food: false
      )
    end
    it { expect(spec.satisfied_by?(container)).to be false }
  end
end

describe '#not' do
  let(:spec) { SanitaryForFoodSpecification.new.not }

  let(:container) do
    Container.new(
      maintainbable_temperatures: -5...5,
      is_sanitary_for_food: true
    )
  end

  it { expect(spec.satisfied_by?(container)).to be false }
end
