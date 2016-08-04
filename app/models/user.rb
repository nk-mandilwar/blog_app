class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
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
end
