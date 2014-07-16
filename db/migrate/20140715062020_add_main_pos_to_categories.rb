class AddMainPosToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :main_pos, :integer
  end
end
