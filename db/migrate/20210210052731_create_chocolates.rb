class CreateChocolates < ActiveRecord::Migration[5.2]
  def change
    create_table :chocolates do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.timestamps null: false
      t.binary :image_data
    end
  end
end
