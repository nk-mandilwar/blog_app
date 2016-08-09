class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	has_many :comments, dependent: :destroy
  
  has_many :friend_requests, foreign_key: "user_id", dependent: :destroy
  has_many :received_friend_requests, class_name: "FriendRequest",
                               foreign_key: "friend_id",
                               dependent: :destroy
  has_many :requests, through: :friend_requests, source: :friend
  has_many :received_requests, through: :received_friend_requests, source: :user                           

  has_many :friendships, dependent: :destroy 
  has_many :friends, through: :friendships

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:twitter]

  VALID_FB_REGEX = /(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
  VALID_STRING_REGEX=/([\w\-\'])([\s]+)?([\w\-\'])/
  validates :name,  presence: true, length: { maximum: 50 }, format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :city,  presence: true, format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :username,  presence: true, uniqueness: true, unless: :uid
  validates :facebook_profile, presence: true, 
                    format: { with: VALID_FB_REGEX },
                    uniqueness: { case_sensitive: false }, unless: :uid

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.username = auth[:info][:nickname]
      user.confirmed_at = Time.now
    end
  end

  def self.new_with_session(params, session)
    if(session["devise.user_attributes"])
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

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
