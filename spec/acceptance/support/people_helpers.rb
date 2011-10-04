module PeopleHelperMethods

  def should_have_person_view_with(opts)
    page.should(have_content opts[:name]) if opts.has_key?(:name)
    find_link(opts[:email]) if opts.has_key?(:email)
    page.should(have_content opts[:position]) if opts.has_key?(:position)
    
    find(:xpath, "//a[contains(@class, 'modify')]")    
  end
  
end

RSpec.configuration.include(PeopleHelperMethods)