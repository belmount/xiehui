class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :link
      t.attachment :img
      t.date :start_at
      t.date :expire_at
      t.string :desc
      t.string :category

      t.timestamps
    end
  end
end
