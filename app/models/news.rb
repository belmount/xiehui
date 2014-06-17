class News < ActiveRecord::Base
  before_save :find_first_image

  def find_first_image
    match_part = /<img.*src="(?<url>\S*)?"/.match(self.content)
    if match_part then  
      self.first_img_url = match_part[:url]
    end
  end


  def thumb_img_url
    if first_img_url? and  /^\/ckeditor_assets\//=== first_img_url then
      first_img_url.gsub(/\/content_/, '/thumb_')
    else
      first_img_url
    end 
  end

  TYPES = {notice: '公告', event: '活动', trends: '行业动态'}

  validates :ntype, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :happend_at, presence: true

  default_scope {order(happend_at: :desc)}
  scope :last5, -> {limit(5)}
end
