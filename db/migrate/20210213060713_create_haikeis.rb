class CreateHaikeis < ActiveRecord::Migration[5.2]
  def change
    create_table :haikeis do |t|
      t.string :imageLink
      t.binary :image_data
      t.timestamps null: false
    end
  end
end
