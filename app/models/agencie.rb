class Agencie < ActiveRecord::Base

  has_many :events, :primary_key => "uid",  dependent: :destroy
  has_many :venues,  dependent: :destroy

  # before_save { |agencie| agencie.name = agencie.name[25...agencie.name.length].gsub(/\//, '') }
  validates_presence_of :name
  validates :name, uniqueness: true
  # validates :name, :format => URI::regexp(%w(http https))



 #  extend FriendlyId
 #  friendly_id :name, use: :slugged

  def self.search(search)
    if search
      where('lower(city) LIKE ?', "%#{search}%")
    else
      all
    end
  end

end
