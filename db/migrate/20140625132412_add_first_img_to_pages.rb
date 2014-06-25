class AddFirstImgToPages < ActiveRecord::Migration
  def change
    add_column :pages, :first_img, :string
  end
end
