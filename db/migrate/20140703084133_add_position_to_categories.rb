class AddPositionToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :position, :int, default: 1
  end
end
