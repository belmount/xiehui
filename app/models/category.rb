class Category < ActiveRecord::Base
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'
  has_many :pages

  validates :name , presence: true
  validates :ename, presence: true

  validate :parent_not_be_self
  validates :display_order, presence: true,  numericality: {only_integer: true}
  def parent_not_be_self
    if parent && parent.id == id then
      errors.add(:parent_id, "上级类型不能为自己")
    end
  end

  default_scope {order(:parent_id, :display_order)}
  scope :first_level, ->{where(parent_id: nil)}
  scope :second_level, ->{where("parent_id is not null")}
  scope :top, -> {where(position: [2, 3])}
  scope :name_like, -> (name) {where('name like :name or ename like :name ', {name: "%#{name}%"})}

  def full_name
    if parent then
      "#{parent.name}/#{name}"
    else
      name
    end
  end

  POSITIONS = {2=> '顶部菜单', 1=> '主页',  3=> '主页和顶部菜单'}

  def position
    self[:position] ? self[:position] : 2 
  end

  def has_url?
    url.present?
  end
end
