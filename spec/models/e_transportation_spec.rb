# spec/models/e_transportation_spec.rb
require 'rails_helper'

RSpec.describe ETransportation, type: :model do
  let(:valid_attributes) do
    {
      transportation_type: :e_bike,
      sensor_type: :medium,
      owner_id: 1,
      in_zone: true,
      lost_sensor: false
    }
  end

  let(:invalid_attributes) do
    {
      transportation_type: nil,
      sensor_type: nil,
      owner_id: nil,
      in_zone: nil
    }
  end

  # Test presence validations using shoulda-matchers
  it { should validate_presence_of(:transportation_type) }
  it { should validate_presence_of(:sensor_type) }
  it { should validate_presence_of(:owner_id) }

  # Enum test with the correct syntax to detect integer mappings
  # it { should define_enum_for(:transportation_type).with_values(e_scooter: 0, e_bike: 1) }
  # it { should define_enum_for(:sensor_type).with_values(small: 0, medium: 1, big: 2) }

  # Custom validation test for uniqueness (Transportation with the same type, sensor, and owner)
  describe 'custom validation for uniqueness' do
    it 'is invalid when there is a duplicate transportation' do
      # Create a record in the database
      FactoryBot.create(:e_transportation, transportation_type: :e_bike, sensor_type: :small, owner_id: 1)

      # Attempt to create the duplicate
      duplicate = FactoryBot.build(:e_transportation, transportation_type: :e_bike, sensor_type: :small, owner_id: 1)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:base]).to include("Transportation with the same type, sensor, and owner already exists.")
    end
  end

  # Test e_scooter? custom method
  describe '#e_scooter?' do
    it 'returns true if transportation_type is e_scooter' do
      e_transportation = FactoryBot.create(:e_transportation, :e_scooter)
      expect(e_transportation.send(:e_scooter?)).to be_truthy
    end

    it 'returns false if transportation_type is not e_scooter' do
      e_transportation = FactoryBot.create(:e_transportation, :e_bike)
      expect(e_transportation.send(:e_scooter?)).to be_falsey
    end
  end

  # Test lost_sensor validation only for e_scooter
  context 'when transportation_type is e_scooter' do
    it 'is valid when lost_sensor is true for e_scooter' do
      e_transportation = FactoryBot.create(:e_transportation, :e_scooter, :lost_sensor)
      expect(e_transportation).to be_valid
    end

    it 'is valid when lost_sensor is false for e_scooter' do
      e_transportation = FactoryBot.create(:e_transportation, :e_scooter, :no_lost_sensor)
      expect(e_transportation).to be_valid
    end
  end

  # Test lost_sensor not required for e_bike
  context 'when transportation_type is e_bike' do
    it 'is valid without lost_sensor for e_bike' do
      e_transportation = FactoryBot.create(:e_transportation, :e_bike, lost_sensor: nil)
      expect(e_transportation).to be_valid
    end
  end

  # Test uniqueness of transportation_type, sensor_type, and owner_id
  describe 'uniqueness of transportation_type, sensor_type, and owner_id' do
    it 'does not allow duplicate transportation_type, sensor_type, and owner_id' do
      # Create the first record
      FactoryBot.create(:e_transportation, transportation_type: :e_bike, sensor_type: :small, owner_id: 1)

      # Attempt to create the duplicate
      duplicate = FactoryBot.build(:e_transportation, transportation_type: :e_bike, sensor_type: :small, owner_id: 1)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:base]).to include("Transportation with the same type, sensor, and owner already exists.")
    end
  end
end
