class Venue < ActiveRecord::Base

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, reject_if: :all_blank #-> seems like you're doing this incorrectly

  belongs_to :supplier
  belongs_to :location
  belongs_to :agencie
  has_many :events, :primary_key => "uid",  dependent: :destroy
  has_many :reverse_relationvenues, foreign_key: "followed_id",
           class_name:  "Relationvenue",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationvenues, source: :follower

  validates :name, presence: true
  validates :lat, presence: true
  validates :lng, presence: true


  def self.search(search)
    if search
      where('lower(name) LIKE ?', "%#{search}%")
    else
      all
    end
  end


  extend FriendlyId
  friendly_id :name, use: :slugged


end
