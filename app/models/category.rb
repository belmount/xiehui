class Category < ActiveRecord::Base
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'
  has_many :pages

  validates :name , presence: true
  validates :ename, presence: true

  validate :parent_not_be_self
  def parent_not_be_self
    if parent && parent.id == id then
      errors.add(:parent_id, "上级类型不能为自己")
    end
  end

  default_scope {order(:parent_id)}
  scope :first_level, ->{where(parent_id: nil)}
  scope :second_level, ->{where("parent_id is not null")}

  def full_name
    if parent then
      "#{parent.name}/#{name}"
    else
      name
    end
  end
end
