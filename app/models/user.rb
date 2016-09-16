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

  has_many :request_friendships, class_name: "Friendship", 
                              foreign_key: "user_id",
                              dependent: :destroy
  has_many :received_friendships, class_name: "Friendship", 
                              foreign_key: "friend_id",
                              dependent: :destroy                             
  has_many :request_friends, through: :request_friendships, source: :friend
  has_many :received_friends, through: :received_friendships, source: :user

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :confirmable, :recoverable, :rememberable, 
         :trackable, :omniauthable, :omniauth_providers => [:twitter], :authentication_keys => [:login]

  VALID_TWITTER_REGEX = /(?:https?:\/\/)?(?:www\.)?twitter\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
  VALID_STRING_REGEX=/([\w\-\'])([\s]+)?([\w\-\'])/
  validates :name, presence: true, length: { maximum: 50 }, format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :city, presence: true, length: { maximum: 50 }, format: { with: VALID_STRING_REGEX }, unless: :uid
  validates :username,  presence: true, length: { maximum: 50 }, 
                    uniqueness: { case_sensitive: false }, unless: :uid
  validates :twitter_profile, length: { maximum: 100 },
                    format: { with: VALID_TWITTER_REGEX },
                    uniqueness: { case_sensitive: false }, unless: :uid

  mount_uploader :image, ImageUploader                    

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.username = auth[:info][:nickname]
      user.name = auth[:info][:name]
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

  def following?(other_user)
    following.include?(other_user)
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

  def following_posts
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", 
                                              user_id: id).order("updated_at DESC")
  end
end
