class Member < ActiveRecord::Base
  TYPES = {member: '会员', council: '理事', ec: '常务理事', vp: '副会长单位'}

  has_attached_file :logo, :styles=>{ :medium => ["300x100>", :png], :thumb => ["150x40>", :png] }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, {presence: true, length: {in: 5..100}, uniqueness: true}
  validates :address, {presence: true, length: {in: 10..100}}
  validates :mtype, {presence: true, inclusion: {in: %w(member council ec vp)}}
  validates :tel,{presence: true, format: {with: /[0-9]{8,13}/}}
  validates :legal_person, {presence:true, length: {in: 2.. 4}}
  validates :legal_tel, {presence: true, format: {with: /[0-9]{8,13}/}}
  validates :contract, {presence:true, length: {in: 2.. 4}}
  validates :contract_tel, {presence: true, format: {with: /[0-9]{8,13}/}}
  validates :url, {format: {with: URI::regexp(%w(http https))}, allow_blank: true}

  belongs_to :user
  has_many :fees
  def type_name
    "#{TYPES[self.mtype.to_sym]}单位"
  end
end