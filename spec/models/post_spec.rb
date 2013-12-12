require 'spec_helper'

describe Post do

  it { should validate_presence_of(:book) }
  it { should validate_presence_of(:club) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }
  
  
  it { should allow_mass_assignment_of(:book_id) }
  it { should allow_mass_assignment_of(:club_id) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:title) }

  
  describe "associations" do
    it { should belong_to(:user)}
    it { should belong_to(:book)}
    it { should belong_to(:club)}
  end
end
