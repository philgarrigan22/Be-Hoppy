class Review < ApplicationRecord
  belongs_to :user
  validates :beer, :brewery, :rating, :user, presence: true
end
