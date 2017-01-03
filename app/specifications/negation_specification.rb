class NegationSpecification < Specification
  def initialize(component)
    @component = component
  end

  def satisfied_by?(container)
    !@component.satisfied_by?(container)
  end
end
