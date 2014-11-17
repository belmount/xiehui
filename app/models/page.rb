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
    else
      self.first_img = nil
    end
  end


  def thumb_img_url
    if first_img? and  /^\/ckeditor_assets\//=== first_img then
      first_img.gsub(/\/content_/, '/thumb_')
    else
      first_img
    end 
  end

  def edit_at
    self[:edit_at] || self[:created_at]
  end

  default_scope {order(edit_at: :desc)}
  scope :with_imgs, ->{where.not(first_img: nil)} 

  scope :with_title, ->(title){where('title like ?', "%#{title}%") if title}
  scope :within_date, ->(date1, date2){where(edit_at: (date1..date2)) if date1 && date2}
  scope :with_type, ->(type){where(category: type.sub_categories) if type}
end
