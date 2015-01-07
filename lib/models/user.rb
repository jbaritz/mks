class User < ActiveRecord::Base
  has_many :adoptions
  validates :username, presence: true, length: { in: 4..12,
    too_long: "%{count} characters is the maximum allowed" }
    validates :password, presence: true, length: {minimum: 6}
end