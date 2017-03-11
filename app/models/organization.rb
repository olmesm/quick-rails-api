class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+\z/ }

  has_many  :workflows
end
