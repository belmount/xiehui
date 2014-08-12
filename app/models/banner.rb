class Banner < ActiveRecord::Base
  TYPES = {partner: '合作伙伴', ad: '广告'}

  has_attached_file :img, :styles=>{ :medium => ["300x200>", :png], :thumb => ["150x100>", :png] }
  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/


  validates :link, {format: {with: URI::regexp(%w(http https))}, allow_blank: false, presence: true}
  validates :category, {presence: true, inclusion: {in: %w(partner ad)}}
  validates :img, presence: true
  validates :desc, presence: true
  validate :date_correct
  def date_correct
    if expire_at < start_at 
      errors.add(:expire_at, '结束时间不能小于开始时间')
    end
  end

  def type_name
    TYPES[category.to_sym]
  end

  scope :ads, -> { where(category: 'ad')}
  scope :partners, -> {where(category: 'partner')}
  scope :in_valid, -> {where("start_at <=:current_date and expire_at >=:current_date", {current_date: Date.today} )}
end
