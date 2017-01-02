class MaximumTemperatureSpecification < Specification
  def initialize(max_temperature)
    @max_temperature = max_temperature
  end

  def is_satisfied_by?(container)
    container.can_maintain_temperature_below?(@max_temperature)
  end
end
