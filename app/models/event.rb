class Event < ApplicationRecord
  has_many :competitions, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_many :event_tags, dependent: :destroy
  has_many :tags, through: :event_tags
  has_one_attached :image
  
  # いいね
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @event = Event.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @event = Event.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @event = Event.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @event = Event.where("name LIKE?","%#{word}%")
    else
      @event = Event.all
    end
  end
  
  def tags_save(tag_list)
    unless self.tags.empty?
      event_tags_records = EventTag.where(event_id: self.id)
      event_tags_records.destroy_all
    end

    tag_list.each do |tag|
      inspected_tag = Tag.find_or_create_by(name: tag)
      self.tags << inspected_tag
    end
  end
end
