require 'spec_helper'

describe User do
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }  
  it { should validate_presence_of(:session_token) }  
  
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:password) }
  
  describe "associations" do
    it { should have_many(:reviews)}
    it { should have_many(:created_clubs)}
    it { should have_many(:posts)}
  end
end
