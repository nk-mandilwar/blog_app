class User < ActiveRecord::Base
  ratyrate_rater
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
  has_many :following_blogs, through: :following, source: :posts
  has_many :followers, through: :passive_relationships
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :confirmable, :recoverable, :rememberable, 
         :trackable, :omniauthable, :omniauth_providers => [:twitter], :authentication_keys => [:login]

  VALID_TWITTER_REGEX = /(?:https?:\/\/)?(?:www\.)?twitter\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
  VALID_STRING_REGEX=/([\w\-\'])([\s]+)?([\w\-\'])/
  validates :name, presence: true, length: { maximum: 50 }, format: { with: VALID_STRING_REGEX }
  validates :city, presence: true, length: { maximum: 50 }, format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :username,  presence: true, length: { maximum: 50 }, 
                    uniqueness: { case_sensitive: false }
  validates :twitter_profile, length: { maximum: 100 },
                    format: { with: VALID_TWITTER_REGEX },
                    uniqueness: { case_sensitive: false }

  mount_uploader :image, ImageUploader                    

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.username = auth[:info][:nickname]
      user.name = auth[:info][:name]
      user.twitter_profile = auth[:info][:urls][:Twitter]
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

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = lower(:value) OR lower(email) = lower(:value)",
                               { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  def password_required?
    super && provider.blank?
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.search(search)
    where("username LIKE ?", "%#{search}%") 
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
    friend.friends.destroy(self)
  end

  def self.fetch_user_relationship(users, current_user)
    relationships = []
    users.each do |user|
      relationship = current_user.active_relationships.find_by(followed_id: user)
      relationships << relationship
    end  
    relationships
  end

  def self.fetch_user_friendship(users, current_user)
    friendships = []
    users.each do |user|
      friendship = current_user.friendships.find_by(friend_id: user)
      friendships << friendship
    end
    friendships
  end

  def self.fetch_user_friend_request(users, current_user)
    friend_requests = []
    users.each do |user|
      friend_request = { received_request: current_user.received_friend_requests.find_by(user_id:  user),
                         sent_request: current_user.friend_requests.find_by(friend_id: user) }
      friend_requests << friend_request
    end
    friend_requests
  end
    
end
