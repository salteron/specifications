class NegationSpecification < Specification
  def initialize(component)
    @component = component
  end

  def is_satisfied_by?(container)
    !@component.is_satisfied_by?(container)
  end
end
