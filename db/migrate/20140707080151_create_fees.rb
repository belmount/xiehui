class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :year
      t.date :pay_at
      t.references :member

      t.timestamps
    end
  end
end
