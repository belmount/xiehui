class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.string :legal_person
      t.string :legal_tel
      t.string :contract
      t.string :contract_tel
      t.string :url
      t.string :logo_url
      t.string :type

      t.timestamps
    end
  end
end
