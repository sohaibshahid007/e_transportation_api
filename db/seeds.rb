# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ETransportation.create([
  { transportation_type: :e_scooter, sensor_type: :big, owner_id: 1, in_zone: false, lost_sensor: true },
  { transportation_type: :e_scooter, sensor_type: :small, owner_id: 2, in_zone: false, lost_sensor: false },
  { transportation_type: :e_bike, sensor_type: :medium, owner_id: 3, in_zone: false },
  { transportation_type: :e_bike, sensor_type: :big, owner_id: 4, in_zone: true }
])
