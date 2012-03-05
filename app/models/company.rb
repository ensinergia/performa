class Company < ActiveRecord::Base
  
  has_one :creed
  has_one :vision
  has_one :mission
  has_one :war_cry
  
  has_many :users
  has_many :areas, :dependent => :destroy, :order=>"id ASC"
  has_many :strategic_lines, :order=>"torder ASC"
  has_many :strategic_objectives, :order=>"torder ASC"
  has_one :swot
  
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[a-zA-Z0-9_[:space:]]*$/
  
  after_initialize :get_default_area, :on => :create
  
  def has_only_one_owner?
    self.users.includes(:position).count(:conditions => ["positions.name = '#{Position.owner}'"]) == 1
  end
  
  def main_area
      self.areas.where(:is_root_area=>true).first
  end  
  
  private
  def get_default_area
    self.areas.first(:conditions => {:name => I18n.t('views.areas.default'), :is_root_area => true}) || build_default_area
  end
  
  def build_default_area
    self.areas.build(:name => I18n.t('views.areas.default'), :is_root_area => true)   
  end
  
end
