class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn, :pic
end
