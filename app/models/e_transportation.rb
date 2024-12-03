class ETransportation < ApplicationRecord
  enum transportation_type: { e_scooter: 0, e_bike: 1 }, _prefix: true
  enum sensor_type: { small: 0, medium: 1, big: 2 }, _prefix: true

  validates :transportation_type, :sensor_type, :owner_id, presence: true
  validates :in_zone, inclusion: { in: [true, false] }, allow_nil: true
  validates :lost_sensor, inclusion: { in: [true, false] }, if: :e_scooter?
  validate :unique_transportation, on: :create

  private

  def e_scooter?
    transportation_type == 'e_scooter'
  end

  # Custom validation to check for uniqueness
  def unique_transportation
    existing_transportation = ETransportation.find_by(
      transportation_type: transportation_type,
      sensor_type: sensor_type,
      owner_id: owner_id
    )

    if existing_transportation
      errors.add(:base, "Transportation with the same type, sensor, and owner already exists.")
    end
  end
end
