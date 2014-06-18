class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.date :edit_at
      t.references :category, index: true

      t.timestamps
    end
  end
end
