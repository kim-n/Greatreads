require 'spec_helper'

describe User do
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:admin) }
  it { should allow_mass_assignment_of(:image) }
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:session_token) }

  describe "associations" do
    it { should have_many(:created_clubs) }
    it { should have_many(:posts) }
    it { should have_many(:tastes) }
    it { should have_many(:rated_books) }
    it { should have_many(:comments) }
    it { should have_many(:follower_entries) }
    it { should have_many(:followee_entries) }
    it { should have_many(:followers) }
    it { should have_many(:follows) }
    it { should have_many(:notifications) }
    it { should have_many(:club_memberships) }
    it { should have_many(:clubs) }
  end
end
