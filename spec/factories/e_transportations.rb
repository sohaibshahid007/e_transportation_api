FactoryBot.define do
  factory :e_transportation do
    transportation_type { :e_bike }
    sensor_type { :medium }
    owner_id { 1 }
    in_zone { true }
    lost_sensor { false }

    # can  be customize or override these values as needed in your tests
    trait :e_scooter do
      transportation_type { :e_scooter }
    end

    trait :in_zone do
      in_zone { true }
    end

    trait :out_of_zone do
      in_zone { false }
    end

    trait :lost_sensor do
      lost_sensor { true }
    end

    trait :no_lost_sensor do
      lost_sensor { false }
    end
  end
end
