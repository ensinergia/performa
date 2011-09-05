# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :opportunity, :class => "Analysis" do |o|
  o.content "An opportunity"
  o.kind Analysis.opportunity
  o.swot { Factory(:swot) }
  o.user { Factory(:user_no_company_name, :company => swot.company) }
end

Factory.define :risk, :class => "Analysis" do |r|  
  r.content "A risk"
  r.kind Analysis.risk
  r.swot { Factory(:swot) }
  r.user { Factory(:user_no_company_name, :company => swot.company) }
end
  
Factory.define :weakness, :class => "Analysis" do |w|
  w.content "A weakness"
  w.kind Analysis.weakness
  w.swot { Factory(:swot) }
  w.user { Factory(:user_no_company_name, :company => swot.company) }
end
  
Factory.define :strength, :class => "Analysis" do |s|  
  s.content "An strength"
  s.kind Analysis.strength
  s.swot { Factory(:swot) }
  s.user { Factory(:user_no_company_name, :company => swot.company) }
end
