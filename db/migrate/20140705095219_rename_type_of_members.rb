class RenameTypeOfMembers < ActiveRecord::Migration
  def change
    rename_column :members, :type, :mtype
  end
end
