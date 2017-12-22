class Image < ActiveRecord::Base


  belongs_to :user
  belongs_to :venue
  belongs_to :event

  has_attached_file :photo, :styles => {:big => "900x900>", :medium => "500x500>", :small => "250x250>" },
                    :url  => ":s3_domain_url",
                    :path => "/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 20.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']


end
