class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :nth
      t.date :open_at
      t.date :end_at

      t.timestamps
    end
  end
end
