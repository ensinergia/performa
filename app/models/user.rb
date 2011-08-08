class User < ActiveRecord::Base  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :last_name, :email, :password, :password_confirmation, :remember_me, :company_name

  has_many :tasks
  belongs_to :area
  belongs_to :company
  belongs_to :position
  before_validation :set_company, :on => :create
  
  validates_associated :company
  validates_presence_of :company
  
  attr_accessor :company_name

  def company_name
    return self.company.name unless self.company.nil?
    @company_name 
  end
  
  def domain
    return company_name.downcase if company_name
    ""
  end

  private
  def set_company
    return if company_name.blank?
    self.company = Company.new({:name => company_name})
  end
end
