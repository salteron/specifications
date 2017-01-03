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

  describe '#special_case_of?' do
    context 'when for EqualSpecification' do
      let(:spec) do
        GreaterOrEqualSpecification.new(1).and(LessOrEqualSpecification.new(1))
      end

      it { expect(spec).not_to be_special_case_of(EqualSpecification.new(1)) }
      it { expect(spec).not_to be_special_case_of(EqualSpecification.new(2)) }
    end

    context 'when for LessOrEqualSpecification' do
      let(:spec) do
        LessOrEqualSpecification.new(1).and(LessOrEqualSpecification.new(5))
      end

      it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(6)) }
      it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(5)) }
      it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(4)) }
      it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(1)) }

      it { expect(spec).not_to be_special_case_of(LessOrEqualSpecification.new(0)) }
    end

    context 'when for GreaterOrEqualSpecification' do
      let(:spec) do
        GreaterOrEqualSpecification.new(1).and(GreaterOrEqualSpecification.new(5))
      end

      it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(0)) }
      it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(1)) }
      it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(4)) }
      it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(5)) }

      it { expect(spec).not_to be_special_case_of(GreaterOrEqualSpecification.new(6)) }
    end

    context 'when for ConjunctionSpecification' do
      let(:spec) do
        GreaterOrEqualSpecification.new(1).and(LessOrEqualSpecification.new(5))
      end

      let(:wider_range) do
        GreaterOrEqualSpecification.new(0).and(LessOrEqualSpecification.new(6))
      end

      xit 'since rule is incorrect' do
        expect(spec).to be_special_case_of(wider_range)
      end
    end
  end

  describe '#generalization_of' do
    context 'when for EqualSpecification' do
      let(:spec) do
        GreaterOrEqualSpecification.new(1).and(LessOrEqualSpecification.new(5))
      end

      it { expect(spec).to be_generalization_of(EqualSpecification.new(1)) }
      it { expect(spec).to be_generalization_of(EqualSpecification.new(2)) }
      it { expect(spec).to be_generalization_of(EqualSpecification.new(5)) }

      it { expect(spec).not_to be_generalization_of(EqualSpecification.new(0)) }
      it { expect(spec).not_to be_generalization_of(EqualSpecification.new(6)) }
    end

    context 'when for LessOrEqualSpecification' do
      let(:spec) do
        LessOrEqualSpecification.new(1).and(LessOrEqualSpecification.new(5))
      end

      it { expect(spec).to be_generalization_of(LessOrEqualSpecification.new(1)) }
      it { expect(spec).to be_generalization_of(LessOrEqualSpecification.new(0)) }
      it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(2)) }
      it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(5)) }
    end

    context 'when for GreaterOrEqualSpecification' do
      let(:spec) do
        GreaterOrEqualSpecification.new(1).and(GreaterOrEqualSpecification.new(5))
      end

      it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(5)) }
      it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(6)) }
      it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(2)) }
      it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(0)) }
    end

    context 'when for ConjunctionSpecification' do
      let(:spec) do
        GreaterOrEqualSpecification.new(1).and(LessOrEqualSpecification.new(5))
      end

      let(:nested_range) do
        GreaterOrEqualSpecification.new(2).and(LessOrEqualSpecification.new(4))
      end

      let(:partially_nested_range) do
        GreaterOrEqualSpecification.new(0).and(LessOrEqualSpecification.new(4))
      end

      let(:outer_range) do
        GreaterOrEqualSpecification.new(0).and(LessOrEqualSpecification.new(6))
      end

      it { expect(spec).to be_generalization_of(nested_range) }
      it { expect(spec).not_to be_generalization_of(partially_nested_range) }
      it { expect(spec).not_to be_generalization_of(outer_range) }
    end
  end
end
