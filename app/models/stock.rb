class Stock < ApplicationRecord
  include Paranoible

  belongs_to :bearer

  validates :name, presence: true, uniqueness: true, allow_blank: false
end
