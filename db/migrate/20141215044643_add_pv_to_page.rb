class AddPvToPage < ActiveRecord::Migration
  def change
    add_column :pages, :pv, :integer
  end
end
