require 'spec_helper'
require_relative '../../app/specifications/specification'
require_relative '../../app/specifications/value_bound_specification'
require_relative '../../app/specifications/equal_specification'
require_relative '../../app/specifications/less_or_equal_specification'
require_relative '../../app/specifications/greater_or_equal_specification'
require_relative '../../app/specifications/conjunction_specification'
require_relative '../../app/specifications/disjunction_specification'

describe DisjunctionSpecification do
  describe '#satisfied_by?' do
    let(:spec) do
      LessOrEqualSpecification.new(-4).or(GreaterOrEqualSpecification.new(4))
    end

    it { expect(spec).to be_satisfied_by(-4) }
    it { expect(spec).to be_satisfied_by(4) }
    it { expect(spec).to be_satisfied_by(-5) }
    it { expect(spec).to be_satisfied_by(5) }

    it { expect(spec).not_to be_satisfied_by(-3) }
    it { expect(spec).not_to be_satisfied_by(3) }
  end

  describe '#special_case_of?' do
    let(:spec) do
      EqualSpecification.new(1).or(EqualSpecification.new(2))
    end

    it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(2)) }
    it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(3)) }
    it { expect(spec).not_to be_special_case_of(LessOrEqualSpecification.new(1)) }

    it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(1)) }
    it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(0)) }
    it { expect(spec).not_to be_special_case_of(GreaterOrEqualSpecification.new(2)) }
  end

  describe '#generalization_of' do
    let(:spec) do
      LessOrEqualSpecification.new(-4).or(GreaterOrEqualSpecification.new(4))
    end

    it { expect(spec).to be_generalization_of(EqualSpecification.new(5)) }
    it { expect(spec).to be_generalization_of(EqualSpecification.new(-5)) }
    it { expect(spec).not_to be_generalization_of(EqualSpecification.new(0)) }

    it { expect(spec).to be_generalization_of(LessOrEqualSpecification.new(-5)) }
    it { expect(spec).to be_generalization_of(LessOrEqualSpecification.new(-4)) }
    it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(-3)) }
    it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(4)) }

    it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(4)) }
    it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(5)) }
    it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(5)) }
    it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(-3)) }
    it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(3)) }
  end
end
