class RegisteredApplication < ApplicationRecord
  belongs_to :user
  has_many :events

  validates :name, presence: true

  validates :url, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3 }
end
