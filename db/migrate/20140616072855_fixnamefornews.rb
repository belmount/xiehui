class Fixnamefornews < ActiveRecord::Migration
  def change
    rename_column :news, :type, :ntype
  end
end
