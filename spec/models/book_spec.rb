require 'spec_helper'

describe Book do
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:author) }
  it { should allow_mass_assignment_of(:isbn) }
  it { should allow_mass_assignment_of(:pic) }
  it { should allow_mass_assignment_of(:description) }

  describe "associations" do
    it { should have_many(:post_items) }
    it { should have_many(:club_pairings) }
    it { should have_many(:tastes) }
  end
end
