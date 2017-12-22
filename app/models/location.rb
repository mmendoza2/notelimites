class Location < ActiveRecord::Base

  belongs_to :supplier

  extend FriendlyId
  friendly_id :name, use: :slugged




  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      all
    end
  end

end
