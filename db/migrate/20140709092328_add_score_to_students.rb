class AddScoreToStudents < ActiveRecord::Migration
  def change
    add_column :students, :score, :decimal, precision: 5, scale: 2
  end
end
