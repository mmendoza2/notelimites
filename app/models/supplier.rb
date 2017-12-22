class Supplier < ActiveRecord::Base

  belongs_to :category
  has_many :events
  has_many :locations
  has_many :venues

end
