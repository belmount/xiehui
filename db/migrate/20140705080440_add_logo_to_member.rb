class AddLogoToMember < ActiveRecord::Migration
  def change
    add_attachment :members, :logo
    remove_column :members, :logo_url
  end
end
