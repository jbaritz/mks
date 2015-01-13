class Adoption < ActiveRecord::Base
  belongs_to :user
  belongs_to :dog
  belongs_to :cat
end