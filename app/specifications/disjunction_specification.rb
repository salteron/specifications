class DisjunctionSpecification < Specification
  def initialize(specifications)
    @specifications = specifications
  end

  def satisfied_by?(value)
    @specifications.any? { |spec| spec.satisfied_by?(value) }
  end

  def generalization_of?(other)
    @specifications.any? { |spec| spec.generalization_of?(other) }
  end

  def special_case_of?(other)
    @specifications.all? { |spec| spec.special_case_of?(other) }
  end
end
