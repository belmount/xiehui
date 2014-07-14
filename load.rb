#load data between two databases

require 'sequel'
Dbdev = Sequel.connect('sqlite://db/development.sqlite3')
Dbprod = Sequel.connect('postgres://xiehui:password@localhost:5432/xiehui')

%w[users categories].each do |table|
  src = Dbdev.from(table)
  target = Dbprod.from(table)
  src.each do |row|
    target.insert(row)
  end
end