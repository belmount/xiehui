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
  validates_format_of :tel, with: /\A\d{8}(|\d{3})\z/, message:'8位或11位数字'
  validates :id_code, presence: true, format: {with: /\A\d{15}(|\d{2}[0-9a-zA-Z])\z/}
  validates :education, presence: true, inclusion: {in: EDUCATION}
  validates :school, presence: true
  validates :school_cert, presence: true
  validates :score, numericality:{less_than_or_equal_to: 100, greater_than_or_equal_to: 0 }, allow_nil: true

  def district_name
    DISTRICT[self[:district]]
  end

  def gender_name
    self[:gender]==='M' ? '男': '女'
  end

  belongs_to :course

  scope :with_course, ->{where('course_id is not null')}
  scope :no_course, ->{where(course: nil)}
  scope :no_score, ->{where(score: nil)}

  scope :with_company, ->(name){where('company_name like ?', "%#{name}%") if name.present?}
  scope :with_name,->(name){where('name like ?', "%#{name}%") if name.present?}
  scope :with_nth, ->(nth){Course.where(nth: nth).students if nth.present?}
  scope :with_id, ->(id_code){where('id_code like ?', "%#{id_code}%") if id_code.present?}


  def self.to_csv(options={})
    # Add BOM to make excel using utf8 to open csv file
    (CSV.generate(options) do |csv|
      csv << %w[姓名 电话 性别 身份证号 学历 学校 证书号 所在区 公司名称 成绩 ]
      map_attr = %w[name tel gender id_code education school school_cert district company_name score]
      all.each do |student|
        csv << [student.name , student.tel, student.gender_name, student.id_code, student.education , student.school, student.school_cert,
          student.district_name, student.company_name, student.score]
      end
    end).encode('gb2312', :undef => :replace, :replace => '')
  end
end
