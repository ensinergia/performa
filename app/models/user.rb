class User < ActiveRecord::Base  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :login, :last_name, :email, :password, :password_confirmation, :remember_me, :company_name,:grade,:officce_phone,:ext_phone,:celular_phone,:fax,:home_phone,:avatar,:avatar_file_name, :avatar_content_type,  :avatar_file_size, :avatar_updated_at
  # Refactor this horrible thing
  has_many :areas
  belongs_to :area
  
  has_many :tasks
  has_many :comments
  has_many :analysis
  has_many :strategic_lines
  has_many :strategic_objectives
  has_many :pointers
  belongs_to :company
  belongs_to :position
  before_validation :set_company, :on => :create
  before_validation :set_position, :on => :create
  
  validates_associated :company, :message => I18n.t('errors.messages.invalid_due_chars')
  validates_presence_of :company
  validates_presence_of :position
  
  attr_accessor :company_name

  before_destroy :destroy_company

  has_attached_file :avatar,
      :storage => :s3,
      :bucket => 'ensinergiaphotos',
      :styles => { :medium => "300x300>", :thumb => "100x100>", :min=>"60X70>"},
      :default_url=>'person.png',
      :s3_credentials => {
        :access_key_id => "AKIAJYKCWTZMXFO2YBNA",
        :secret_access_key => "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"
      }
      
  def self.change_role_for(users)
    users.each_key do |key|
      user=self.find(key)
      user.update_attribute(:position_id, users[key]) if user.position != users[key]
    end
  end

  def role?(role_id)
    return self.position.role_equivalence == role_id
  end

  def company_name
    return self.company.name unless self.company.nil?
    @company_name 
  end
  
  def subdomain
    return company_name.downcase.gsub(" ", "") if company_name
    ""
  end

  def full_name
    "#{name} #{last_name}"
  end

  def is_owner?
    return false if self.position.nil?
    self.position.name == Position.owner
  end

  def is_admin?
    return false if self.position.nil?
    self.position.name == Position.admin
  end


  private
  def set_company
    return unless company.nil?
    return if company_name.blank?
    return unless Company.find_by_name(company_name).nil?

    self.position = Position.get_owner
    self.company = Company.new({:name => company_name})
    # also add user to company default's area
    self.area = self.company.areas.first
  end
  
  def set_position
    return unless position.nil?

    self.position = Position.get_owner
  end
  
  def destroy_company
    self.company.destroy if self.company.has_only_one_owner? && self.is_owner?
  end
end
