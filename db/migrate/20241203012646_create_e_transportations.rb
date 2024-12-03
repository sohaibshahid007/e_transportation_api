class CreateETransportations < ActiveRecord::Migration[7.0]
  def change
    create_table :e_transportations do |t|
      t.integer :transportation_type, null: false, default: 0
      t.integer :sensor_type, null: false, default: 0
      t.integer :owner_id, null: false
      t.boolean :in_zone
      t.boolean :lost_sensor

      t.timestamps
    end
  end
end
