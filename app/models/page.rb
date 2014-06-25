class Page < ActiveRecord::Base
  belongs_to :category
  validates :category, presence: true
  validates :title, presence: true
  validates :content, presence: true


  before_save :get_first_image

  def get_first_image
    match_part = /<img.*src="(?<url>\S*)?"/.match(self.content)
    if match_part then  
      self.first_img = match_part[:url]
    end
  end


  def thumb_img_url
    if first_img_url? and  /^\/ckeditor_assets\//=== first_img_url then
      first_img_url.gsub(/\/content_/, '/thumb_')
    else
      first_img_url
    end 
  end

  default_scope {order(edit_at: :desc)}
end
