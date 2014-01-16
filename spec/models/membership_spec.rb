require 'spec_helper'

describe Membership do
  it { should allow_mass_assignment_of(:club_id) }
  it { should allow_mass_assignment_of(:user_id) }
  
  describe "associations" do 
    it { should belong_to(:user) }
    it { should belong_to(:club) }
  end
end
