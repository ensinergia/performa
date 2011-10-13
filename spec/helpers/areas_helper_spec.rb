require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AreasHelper. For example:
#
# describe AreasHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AreasHelper do
  
  before(:each) do
    @owner_p = Factory(:owner_position)
    @user_p = Factory(:user_position)
    @other_p = Factory(:position, :name => "newbie")
    
    @user = Factory.build(:user, :position => @owner_p)
  end
  
  it "should translate the available set of positions, leaving the undefined untranslated" do
    translated_permissions_for_select_for(@user).should == "<option value=\"1\" selected=\"selected\">#{I18n.t("views.positions.#{@owner_p.name}")}</option>\n<option value=\"2\">#{I18n.t("views.positions.#{@user_p.name}")}</option>\n<option value=\"3\">Newbie</option>"
  end
end
