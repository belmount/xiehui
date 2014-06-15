class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.string :type
      t.date :happend_at
      t.string :first_img_url

      t.timestamps
    end
  end
end
