class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :rememberable, :trackable, :validatable
  ROLES = {admin: '管理员', editor: '编辑', member: '会员'}

  has_one :member

  validates :role, {presence: true}

  def role_name
    ROLES[self.role.to_sym]
  end

  def member_name
    if member
      member.name
    else
      ''
    end
  end
end
