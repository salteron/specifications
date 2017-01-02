class SanitaryForFoodSpecification < Specification
  def is_satisfied_by?(container)
    container.is_sanitary_for_food?
  end
end
