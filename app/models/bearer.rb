class Bearer < ApplicationRecord
  has_many :stocks

  validates :name, presence: true, uniqueness: true, allow_blank: false
end
