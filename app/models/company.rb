class Company < ActiveRecord::Base
  has_many :users
  has_many :areas
  
  validates_uniqueness_of :name
  
  before_create :register_default_area, :on => :create
  
  private
  def register_default_area
    self.areas.build(:name => I18n.t('views.areas.default'))
  end
  
end
