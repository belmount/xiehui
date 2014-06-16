class News < ActiveRecord::Base
  before_save :find_first_image

  def find_first_image
    if content =~ /<img.*src="(?<url>\S*)?"/ then 
      first_img_url = /<img.*src="(?<url>\S*)?"/.match(content)[:url]
    end
  end

  TYPES = {notice: '公告', event: '活动', trends: '行业动态'}

  validates :ntype, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :happend_at, presence: true
end
