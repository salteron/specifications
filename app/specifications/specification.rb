class Specification
  def is_satisfied_by?(container)
    false
  end

  def and(other)
    ConjunctionSpecification.new([self, other])
  end

  def not
    NegationSpecification.new(self)
  end
end
