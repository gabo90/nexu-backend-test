class CreateModels < ActiveRecord::Migration[7.0]
  def change
    create_table :models do |t|
      t.references :brand, null: false, foreign_key: true, index: true
      t.string :name, null: false
      t.integer :average_price, null: true

      t.timestamps
    end
  end
end
