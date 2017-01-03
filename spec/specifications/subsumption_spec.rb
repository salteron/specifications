require 'spec_helper'

require_relative '../../app/specifications/specification'

class ValueBoundSpecification < Specification
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def generalization_of?(other)
    other.special_case_of?(self)
  end
end

class EqualSpecification < ValueBoundSpecification
  def is_satisfied_by?(other)
    other == @value
  end

  def special_case_of?(other)
    case other
    when EqualSpecification
      other.is_satisfied_by?(value)
    when LessOrEqualSpecification
      other.is_satisfied_by?(value)
    when GreaterOrEqualSpecification
      other.is_satisfied_by?(value)
    else
      false
    end
  end
end

class LessOrEqualSpecification < ValueBoundSpecification
  def is_satisfied_by?(other)
    other <= @value
  end

  def special_case_of?(other)
    return false unless other.is_a?(self.class)
    other.is_satisfied_by?(value)
  end
end

class GreaterOrEqualSpecification < ValueBoundSpecification
  def is_satisfied_by?(other)
    other >= @value
  end

  def special_case_of?(other)
    return false unless other.is_a?(self.class)
    other.is_satisfied_by?(value)
  end
end

describe EqualSpecification do
  let(:spec) { described_class.new(42) }

  describe '#is_satisfied_by?' do
    it { expect(spec.is_satisfied_by?(42)).to be true }
    it { expect(spec.is_satisfied_by?(3)).to be false }
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

describe LessOrEqualSpecification do
  let(:spec) { described_class.new(42) }
  it { expect(spec.is_satisfied_by?(42)).to be true }
  it { expect(spec.is_satisfied_by?(41)).to be true }
  it { expect(spec.is_satisfied_by?(43)).to be false }

  describe '#special_case_of?' do
    it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(42)) }
    it { expect(spec).to be_special_case_of(LessOrEqualSpecification.new(43)) }
    it { expect(spec).not_to be_special_case_of(LessOrEqualSpecification.new(41)) }

    it { expect(spec).not_to be_special_case_of(EqualSpecification.new(42)) }
    it { expect(spec).not_to be_special_case_of(GreaterOrEqualSpecification.new(42)) }
  end

  describe '#generalization_of?' do
    it { expect(spec).to be_generalization_of(LessOrEqualSpecification.new(41)) }
    it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(43)) }

    it { expect(spec).to be_generalization_of(EqualSpecification.new(42)) }
    it { expect(spec).to be_generalization_of(EqualSpecification.new(41)) }
    it { expect(spec).not_to be_generalization_of(EqualSpecification.new(43)) }

    it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(42)) }
  end
end

describe GreaterOrEqualSpecification do
  let(:spec) { described_class.new(42) }
  it { expect(spec.is_satisfied_by?(42)).to be true }
  it { expect(spec.is_satisfied_by?(43)).to be true }
  it { expect(spec.is_satisfied_by?(41)).to be false }

  describe '#special_case_of?' do
    it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(41)) }
    it { expect(spec).to be_special_case_of(GreaterOrEqualSpecification.new(42)) }
    it { expect(spec).not_to be_special_case_of(GreaterOrEqualSpecification.new(43)) }

    it { expect(spec).not_to be_special_case_of(EqualSpecification.new(42)) }
    it { expect(spec).not_to be_special_case_of(LessOrEqualSpecification.new(42)) }
  end

  describe '#generalization_of?' do
    it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(43)) }
    it { expect(spec).to be_generalization_of(GreaterOrEqualSpecification.new(42)) }
    it { expect(spec).not_to be_generalization_of(GreaterOrEqualSpecification.new(41)) }

    it { expect(spec).to be_generalization_of(EqualSpecification.new(42)) }
    it { expect(spec).to be_generalization_of(EqualSpecification.new(43)) }
    it { expect(spec).not_to be_generalization_of(EqualSpecification.new(41)) }

    it { expect(spec).not_to be_generalization_of(LessOrEqualSpecification.new(42)) }
  end
end
