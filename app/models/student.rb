class Student < ActiveRecord::Base
  EDUCATION= %w[研究生 本科 大专 高中 中专]
  DISTRICT={'ja'=>'江岸区',"jh"=>"江汉区",
      'qk'=>'硚口区', 'hy'=>'汉阳区', 'wc'=>'武昌区',
      'hs'=>'洪山区', 'qs'=>'青山区', 
      'jx'=>'江夏区', 'dxh'=>'东西湖区',
      'hp'=>'黄陂区', 'xz'=>'新洲区', 'cd'=>'蔡甸区',
      'hn'=>'汉南区', 'dhgx'=>'东湖高新', 'whkfq'=>'武汉经济技术开发区',
      'dhfjq'=>'东湖风景区'}

  validates :name, presence: true, length: {in: 2..5}
  validates :gender, presence: true, inclusion: { in: %w{F M}}
  validates :company_name, presence: true, length: {in: 5..50}
  validates :tel, presence: true, length: {in:8..11}
  validates_format_of :tel, with: /\A\d{10}(\d{0}|\d{3})\z/, message:'8位或11位数字'
  validates :id_code, presence: true, format: {with: /\A\d{15}(|\d{2}[0-9a-zA-Z])\z/}
  validates :education, presence: true, inclusion: {in: EDUCATION}
end
