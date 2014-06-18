class Category < ActiveRecord::Base
  has_many :sub_category, class_name: 'Category', foreign_key: 'parent'
  belongs_to :parent, class_name: 'Category'

  validates :name , presence: true
  validates :ename, presence: true

  validate :parent_not_be_self
  def parent_not_be_self
    if parent_id == id then
      errors.add(:parent_id, "上级类型不能为自己")
    end
  end

  default_scope {order(:parent_id)}
  scope :first_level, ->{where(parent_id: nil)}
end
