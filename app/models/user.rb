class User < ActiveRecord::Base
  has_many :program

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :uniqueness => {:case_sensitive => false}

  def name
    "#{firstname} #{lastname}"
  end
end
