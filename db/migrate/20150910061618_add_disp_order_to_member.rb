class AddDispOrderToMember < ActiveRecord::Migration
  def change
    add_column :members, :disp_order, :integer, null: true
    add_index :members, :disp_order
  end
end
