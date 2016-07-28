class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  VALID_FB_REGEX = /(?:https?:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-\.]*)/
  VALID_STRING_REGEX=/([\w\-\'])([\s]+)?([\w\-\'])/
  validates :name,  presence: true, length: { maximum: 50 }, format: { with: VALID_STRING_REGEX }
  validates :city,  presence: true, format: { with: VALID_STRING_REGEX }
  validates :username,  presence: true, uniqueness: true
  validates :facebook_profile, presence: true, 
                    format: { with: VALID_FB_REGEX },
                    uniqueness: { case_sensitive: false }
end
