class User < ActiveRecord::Base
  has_many :adoptions
  validates :username, presence: true, length: { in: 4..12,
    too_long: "%{count} characters is the maximum allowed" }
  validates :password, presence: true, length: {minimum: 6}, format: /[a-zA-Z]+\d+|\d+[a-zA-Z]+/

def has_password? poss_password
  self.password == poss_password
end
end