class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :product_id
      t.integer :product_name
      t.integer :total_price
      t.string :currency
      t.integer :user_id

      t.timestamps
    end
  end
end
