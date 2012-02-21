class Swot < ActiveRecord::Base
  
  has_many :analyses do
    def strengths
      all(:conditions => {:kind => Analysis.strength},:include => [:comments], :order=>'torder ASC')
    end
    
    def weaknesses
      all(:conditions => {:kind => Analysis.weakness},:include => [:comments], :order=>'torder ASC')
    end
    
    def opportunities
      all(:conditions => {:kind => Analysis.opportunity},:include => [:comments], :order=>'torder ASC')
    end
    
    def risks
      all(:conditions => {:kind => Analysis.risk},:include => [:comments], :order=>'torder ASC')
    end
  end
  
  belongs_to :company
  has_many :comments, :as => :commentable
  
  def self.get_internals_for(company)
    swot = self.get_swot_for(company)
    return {} if swot.nil? 
    {:strengths => swot.analyses.strengths, :weaknesses => swot.analyses.weaknesses}
  end
  
  def self.get_externals_for(company)
    swot = self.get_swot_for(company)   
    return {} if swot.nil? 
    {:opportunities => swot.analyses.opportunities, :risks => swot.analyses.risks}
    
  end
    
  def self.get_swot_for(company)  
    self.where(:company_id => company.id).first
  end
end
