class Category < ActiveRecord::Base
  POSITIONS = {2=> '顶部菜单', 1=> '主页',  3=> '主页和顶部菜单'}
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'
  has_many :pages

  validates :name , presence: true
  validates :ename, presence: true, uniqueness: true

  validate :parent_not_be_self
  validate :need_main_pos
  validate :need_icon
  validates :display_order, presence: true,  numericality: {only_integer: true}
  validates :main_pos, numericality: {only_integer: true, greater_than_or_equal_to: 0}, allow_nil: true
  def parent_not_be_self
    if parent && parent.id == id then
      errors.add(:parent_id, "上级类型不能为自己")
    end
  end

  def need_main_pos
    # check just for first level category
    if first_level_main_page? and main_pos.nil? # main_pos
      errors.add(:main_pos, "不能为空")
    end
  end

  def first_level_main_page?
    (position & 1 ) and  parent.nil?
  end

  def need_icon
    if first_level_main_page? and icon_name.blank? # main_pos
      errors.add(:icon_name, "不能为空")
    end
  end

  default_scope {order(:parent_id, :display_order)}
  scope :first_level, ->{where(parent_id: nil)}
  scope :second_level, ->{where("parent_id is not null")}
  scope :top, -> {where(position: [2, 3])}
  scope :main_page, -> {where(position: [1,3]).order('main_pos asc')}
  scope :name_like, -> (name) {where('name like :name or ename like :name ', {name: "%#{name}%"})}
  scope :main_pos_at, ->(pos){first_level.main_page.where(main_pos: pos).first}
  scope :no_news, -> {first_level.main_page.where.not(main_pos: 0)}

  def full_name
    if parent then
      "#{parent.name}/#{name}"
    else
      name
    end
  end

  

  def position
    self[:position] ? self[:position] : 2 
  end

  def has_url?
    url.present?
  end
end
