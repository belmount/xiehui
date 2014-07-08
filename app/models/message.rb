class Message < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 2}
  validates :content, presence: true, length: {minimum: 30}

  default_scope ->{order(updated_at: :desc)}
  scope :with_title, ->(title){where('title like ?', "%#{title}%") if title.present?}
end
