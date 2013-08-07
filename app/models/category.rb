class Category < ActiveRecord::Base
  attr_accessible :category_id, :name
#  add_index( :categories, [:category_id], :unique => true )
end
