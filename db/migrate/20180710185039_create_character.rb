class CreateCharacter < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :saying
      t.integer :room_id
    end
  end
end
