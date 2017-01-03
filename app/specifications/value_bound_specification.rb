class ValueBoundSpecification < Specification
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def generalization_of?(other)
    other.special_case_of?(self)
  end
end
