require 'spec_helper'
require_relative '../../app/specifications/specification'
require_relative '../../app/specifications/value_bound_specification'
require_relative '../../app/specifications/equal_specification'
require_relative '../../app/specifications/less_or_equal_specification'
require_relative '../../app/specifications/greater_or_equal_specification'

describe EqualSpecification do
  let(:spec) { described_class.new(42) }

  describe '#satisfied_by?' do
    it { expect(spec.satisfied_by?(42)).to be true }
    it { expect(spec.satisfied_by?(3)).to be false }
  end

  describe '#special_case_of?' do
    it { expect(spec).to be_special_case_of(EqualSpecification.new(42)) }
    it { expect(spec).not_to be_special_case_of(EqualSpecification.new(41)) }

    it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(43)) }
    it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(42)) }
    it { expect(spec).not_to be_special_case_of(LessOrEqualSpecification.new(41)) }

    it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(41)) }
    it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(42)) }
    it { expect(spec).not_to be_special_case_of(GreaterOrEqualSpecification.new(43)) }
  end

  describe '#generalization_of?' do
    it { expect(spec).to be_generalization_of(EqualSpecification.new(42)) }
    it { expect(spec).not_to be_generalization_of(EqualSpecification.new(41)) }

    it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(42)) }
    it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(42)) }
  end
end
