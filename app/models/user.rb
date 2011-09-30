class User < ActiveRecord::Base  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :last_name, :email, :password, :password_confirmation, :remember_me, :company_name

  has_many :tasks
  has_many :comments
  has_many :analysis
  has_many :strategic_lines
  has_many :strategic_objectives
  
  belongs_to :area
  belongs_to :company
  belongs_to :position
  before_validation :set_company, :on => :create
  before_validation :set_position, :on => :create
  
  validates_associated :company
  validates_presence_of :company
  validates_presence_of :position
  
  attr_accessor :company_name

  def company_name
    return self.company.name unless self.company.nil?
    @company_name 
  end
  
  def subdomain
    return company_name.downcase if company_name
    ""
  end

  def full_name
    "#{name} #{last_name}"
  end

  private
  def set_company
    return unless company.nil?
    return if company_name.blank?
    return unless Company.find_by_name(company_name).nil?

    self.company = Company.new({:name => company_name})
    # also add user to company default's area
    self.area = self.company.areas.first
  end
  
  def set_position
    return unless position.nil?

    self.position = Position.new({:name => I18n.t('views.people.default_position')})
  end
end
