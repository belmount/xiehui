class Member < ActiveRecord::Base
  TYPES = {member: '会员', council: '理事', ec: '常务理事', vp: '副会长单位'}

  has_attached_file :logo, :styles=>{ :medium => "300x100>", :thumb => "150x40>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end