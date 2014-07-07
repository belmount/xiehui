class Fee < ActiveRecord::Base
  belongs_to :member

  validates :year, presence: true, numericality: {only_integer: true, greater_than: 2005}
  validates :pay_at, presence: true

  default_scope ->{order(year: :desc)}
end