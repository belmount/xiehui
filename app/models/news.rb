class News < ActiveRecord::Base
  before_save :find_first_image

  def find_first_image
    image_url = /<img.*src="(?<url>\S*)?"/.match(content)[:url]
  end
end
