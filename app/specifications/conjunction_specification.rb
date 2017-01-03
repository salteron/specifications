class ConjunctionSpecification < Specification
  def initialize(specifications)
    @specifications = specifications
  end

  def satisfied_by?(value)
    @specifications.all? { |spec| spec.satisfied_by?(value) }
  end

  def special_case_of?(other)
    # неправильное правило (AnB) scof C <=> C gof A || C gof B
    @specifications.any? { |spec| other.generalization_of?(spec) }
  end

  def generalization_of?(other)
    @specifications.all? { |spec| spec.generalization_of?(other) }
  end
end
