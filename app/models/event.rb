class Event < ApplicationRecord
  has_many :competitions, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_many :event_tags, dependent: :destroy
  has_many :tags, through: :event_tags
  has_one_attached :image
  
  has_many :notifications, dependent: :destroy
  
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
  
  # いいね通知
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        event_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  # コメント通知
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, event_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, event_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, event_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      event_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
