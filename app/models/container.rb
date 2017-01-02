class Container
  def initialize(maintainbable_temperatures:, is_sanitary_for_food:)
    @maintainbable_temperatures = maintainbable_temperatures
    @is_sanitary_for_food = is_sanitary_for_food
  end

  def can_maintain_temperature_below?(temperature)
    @maintainbable_temperatures.include?(temperature)
  end

  def is_sanitary_for_food?
    @is_sanitary_for_food
  end
end
