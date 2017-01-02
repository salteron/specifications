class ConjunctionSpecification < Specification
  def initialize(specifications)
    @specifications = specifications
  end

  def is_satisfied_by?(container)
    @specifications.all? { |spec| spec.is_satisfied_by?(container) }
  end
end
