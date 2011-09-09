class Company < ActiveRecord::Base
  
  has_one :creed
  has_one :vision
  has_one :mission
  has_one :war_cry
  
  has_many :users
  has_many :areas
  has_one :swot
  
  validates_uniqueness_of :name
  
  after_initialize :get_default_area, :on => :create
  
  private
  def get_default_area
    self.areas.first(:conditions => {:name => I18n.t('views.areas.default')}) || build_default_area
  end
  
  def build_default_area
    self.areas.build(:name => I18n.t('views.areas.default'))   
  end
  
end
