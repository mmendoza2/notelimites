class Event < ActiveRecord::Base

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: :all_blank #-> seems like you're doing this incorrectly

  belongs_to :supplier
  belongs_to :category
  belongs_to :agencie
  belongs_to :venue, :primary_key => "uid"

  has_many :followers, through: :reverse_relationevents, source: :follower
  has_many :reverse_relationevents, foreign_key: "followed_id",
           class_name:  "Relationevent",
           dependent:   :destroy

  validates :uid, uniqueness: true




  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      all
    end
  end


  def venue_name
    venue.try(:name)
  end

  def venue_name=(name)
    self.name = Venue.find_by_name(name) if name.present?
  end


  extend FriendlyId
  friendly_id :name, use: :slugged

end
