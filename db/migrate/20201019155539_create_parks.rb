class CreateParks < ActiveRecord::Migration[6.0]
  def change
    create_table :parks do |t|
      t.string :type
      t.integer :hour, default: 0
      t.integer :fee, default: 0

      t.timestamps
    end
  end
end
