class Specification
  def satisfied_by?(_)
    false
  end

  def and(other)
    ConjunctionSpecification.new([self, other])
  end

  def or(other)
    DisjunctionSpecification.new([self, other])
  end

  def not
    NegationSpecification.new(self)
  end
end
