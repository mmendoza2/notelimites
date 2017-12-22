class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,  :omniauthable,
         :recoverable, :rememberable, :trackable

  has_many :images
  has_many :venues
  has_many :events

      has_many :relationcategories, foreign_key: "follower_id", dependent: :destroy
      has_many :followed_categories, through: :relationcategories, source: :followed

  has_many :relationevents, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_events, through: :relationevents, source: :followed

      has_many :relationvenues, foreign_key: "follower_id", dependent: :destroy
      has_many :followed_venues, through: :relationvenues, source: :followed

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_create :create_remember_token

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.editor = false
        user.uid = auth.uid
        user.name = auth.info.name
        user.email  = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.image = auth.info.image
        user.save!
      end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end





  extend FriendlyId
  friendly_id :name, use: :slugged

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end




  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

      def followingevent?(other_user)
        relationevents.find_by(followed_id: other_user.id)
      end
      def followevent!(other_user)
        relationevents.create!(followed_id: other_user.id)

      end
      def unfollowevent!(other_user)
        relationevents.find_by(followed_id: other_user.id).destroy!
      end

  def followingvenue?(other_user)
    relationvenues.find_by(followed_id: other_user.id)
  end
  def followvenue!(other_user)
    relationvenues.create!(followed_id: other_user.id)
  end
  def unfollowvenue!(other_user)
    relationvenues.find_by(followed_id: other_user.id).destroy!
  end






  def followingcategory?(other_user)
    relationcategories.find_by(followed_id: other_user.id)
  end
  def followcategory!(other_user)
    relationcategories.create!(followed_id: other_user.id)
  end
  def unfollowcategory!(other_user)
    relationcategories.find_by(followed_id: other_user.id).destroy!
  end



  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
