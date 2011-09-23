class ContextualLegend < ActiveRecord::Base
  validates_presence_of :content, :url
end
