class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name, limit: 30
      t.string :tel, limit: 30
      t.string :gender, limit: 1
      t.string :education
      t.string :company_name, limit:100
      t.string :company_code, limit:20
      t.string :id_code,limit: 30
      t.string :district, limit: 10
      t.string :school,limit: 100
      t.string :school_cert, limit: 100

      t.timestamps
    end
  end
end
