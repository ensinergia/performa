class Project < ActiveRecord::Base
    
    
  #*************************************************
  #                   Relations                    *
  #*************************************************
  belongs_to :user
  belongs_to :company
  has_many :liabilities, :dependent => :destroy
  has_many :profits, :dependent => :destroy
  has_many :restrictions, :dependent => :destroy
  has_and_belongs_to_many :operative_objectives, :uniq => true
  accepts_nested_attributes_for :liabilities, :restrictions, :profits, :allow_destroy => true
  
  #*************************************************
  #                   Instance Methods             *
  #*************************************************
  def notify_to(users)
  end

  
  def self.get_all_for(id)
    self.where(:area_id =>id)
  end

  
end
