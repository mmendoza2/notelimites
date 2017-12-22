class Category < ActiveRecord::Base

  has_many :events
  has_many :agencies

  has_many :reverse_relationcategorias, foreign_key: "followed_id",
           class_name: "Relationcategory",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationcategorias, source: :follower


  has_attached_file :photo, :styles => {:biggest => "900x900>", :big => "600x600>", :medium => "400x400>", :small => "200x200>", :smallest =>"100x100>" },
                    :url  => ":s3_domain_url",
                    :path => "/:class/:attachment/:id_partition/:style/:filename"


end