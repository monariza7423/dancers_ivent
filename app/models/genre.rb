class Genre < ApplicationRecord
  has_many :competitions, dependent: :destroy
end
