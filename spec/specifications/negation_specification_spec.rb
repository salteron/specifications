require 'spec_helper'
require_relative '../../app/models/container'
require_relative '../../app/specifications/specification'
require_relative '../../app/specifications/value_bound_specification'
require_relative '../../app/specifications/equal_specification'
require_relative '../../app/specifications/less_or_equal_specification'
require_relative '../../app/specifications/greater_or_equal_specification'
require_relative '../../app/specifications/conjunction_specification'
require_relative '../../app/specifications/disjunction_specification'
require_relative '../../app/specifications/sanitary_for_food_specification'
require_relative '../../app/specifications/negation_specification'

describe NegationSpecification do
  let(:spec) { described_class.new(component) }
  let(:component) { SanitaryForFoodSpecification.new }

  let(:container) do
    Container.new(maintainbable_temperatures: [], is_sanitary_for_food: true)
  end

  it { expect(component.satisfied_by?(container)).to be true }
  it { expect(spec.satisfied_by?(container)).to be false }
end
