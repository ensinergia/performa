class Company < ActiveRecord::Base
  
  has_one :vision, :conditions => { :current => true }
  
  has_many :users
  has_many :areas
  
  validates_uniqueness_of :name
  
  after_initialize :register_default_area, :on => :create
  
  private
  def register_default_area
    self.areas.build(:name => I18n.t('views.areas.default'))   
  end
  
end
