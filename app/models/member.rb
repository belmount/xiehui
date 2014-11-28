class Member < ActiveRecord::Base
  TYPES = {member: '会员', council: '理事', ec: '常务理事', vp: '副会长单位'}

  has_attached_file :logo, :styles=>{ :medium => ["300x100>", :png], :thumb => ["150x40>", :png] }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, {presence: true, length: {in: 5..100}, uniqueness: true}
  validates :address, {presence: true,length: {in: 10..100}}
  validates :mtype, {presence: true, inclusion: {in: %w(member council ec vp)}}
  validates :tel,{presence: true, format: {with: /[0-9]{8,13}/}}
  validates :legal_person, {presence:true, length: {in: 2.. 4}}
  validates :legal_tel, { presence: true,format: {with: /[0-9]{8,13}/}}
  validates :contract, {presence:true, length: {in: 2.. 4}}
  validates :contract_tel, { presence: true, format: {with: /[0-9]{8,13}/}}
  validates :url, {format: {with: URI::regexp(%w(http https))}, allow_blank: true}

  belongs_to :user
  has_many :fees
  def type_name
    "#{TYPES[self.mtype.to_sym]}单位"
  end

  def url
    if self[:url].blank? then 
      "http://jjjg.027xf.com/agency/#{self[:name]}" 
    else
      self[:url]
    end
  end

  def self.to_csv(options={})
    # Add BOM to make excel using utf8 to open csv file
    (CSV.generate(options) do |csv|
      csv << %w[单位名称 法人姓名 法人电话 联系人 联系人电话]
      map_attr = %w[name legal_person legal_tel contract contract_tel]
      all.each do |member|
        csv << [member.name , member.legal_person, member.legal_tel, member.contract, member.contract_tel ]
      end
    end).encode('gb2312', :undef => :replace, :replace => '')
  end

  scope :name_with, ->(name){where('name like ?', "%#{name}%") if name.present?}
end