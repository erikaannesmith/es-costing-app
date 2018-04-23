class Client < ApplicationRecord
  belongs_to :user
  has_many :styles
  validates_presence_of :email, :name
end
