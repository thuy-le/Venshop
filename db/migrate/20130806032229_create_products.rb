class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.string :imgurl
      t.string :price
      t.string :currency
      t.string :description

      t.timestamps
    end
  end
end
