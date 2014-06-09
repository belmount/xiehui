class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
