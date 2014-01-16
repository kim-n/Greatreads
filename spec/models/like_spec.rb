require 'spec_helper'

describe Like do
  it { should allow_mass_assignment_of(:book_id) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:taste) }
  
  it { should validate_presence_of(:book_id) }
  it { should validate_presence_of(:taste) }
  it { should validate_presence_of(:user) }
  it {should ensure_inclusion_of(:taste).in_array(%w[-1 0 1]) }
  
  describe "associations" do 
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end
