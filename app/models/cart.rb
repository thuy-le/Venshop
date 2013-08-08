class Cart < ActiveRecord::Base
  attr_accessible :currency, :product_id, :product_name, :total_price, :user_id
end
