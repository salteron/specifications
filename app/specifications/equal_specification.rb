class EqualSpecification < ValueBoundSpecification
  def satisfied_by?(other)
    other == @value
  end

  def special_case_of?(other)
    other.is_a?(ValueBoundSpecification) && other.satisfied_by?(value)
  end
end
