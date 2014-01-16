require 'spec_helper'

describe Follow do
  it { should allow_mass_assignment_of(:followee_id) }
  it { should allow_mass_assignment_of(:follower_id) }
  
  describe "associations" do
    it { should belong_to(:follower) }
    it { should belong_to(:followee) }
  end
end
