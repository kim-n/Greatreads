require 'spec_helper'

describe Club do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:creator) }  
  
  it { should allow_mass_assignment_of(:title) }
  
  describe "associations" do
    it { should belong_to(:creator) }
    it { should have_many(:posts) }
    it { should have_many(:book_pairings) }
    it { should have_many(:books) }
  end

end
