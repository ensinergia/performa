class Company < ActiveRecord::Base
  
  has_one :vision, :conditions => { :current => true }
  
  has_many :users
  has_many :areas
  
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
