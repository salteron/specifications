class SanitaryForFoodSpecification < Specification
  def satisfied_by?(container)
    container.is_sanitary_for_food?
  end
end
