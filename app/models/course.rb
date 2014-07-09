class Course < ActiveRecord::Base
  validates_presence_of :nth, :open_at, :end_at
  validates :nth, numericality: {greater_than: 0, only_integer: true}

  validate :end_greater_than_open

  def end_greater_than_open
    if end_at < open_at 
      errors.add(:end_at, '结束时间不能小于开始时间')
    end
  end

  has_many :students

  default_scope ->{order(open_at: :desc)}
  scope :recent, ->{limit(5)}
end
