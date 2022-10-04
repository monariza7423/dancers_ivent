class Event < ApplicationRecord
  has_many :competition, dependent: :destroy
end
