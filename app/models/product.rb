class Product < ActiveRecord::Base
  attr_accessible :category_id, :currency, :description, :imgurl, :name, :price, :user_id
end
