class Subscribe < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true,
												format: { with: VALID_EMAIL_REGEX }
	validates :security_ans, presence: true, length: {minimum: 3}
  validates :security_question, presence: true

  enum security_question: { pet_name: 0, favourite_color: 1, first_possession: 2,
                                                    mother_name: 3,  lover_name: 4}
end
