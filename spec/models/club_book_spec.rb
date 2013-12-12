require 'spec_helper'

describe ClubBook do
  
  it { should validate_presence_of(:book_id) }
  it { should validate_presence_of(:club_id) }  
  
  it { should allow_mass_assignment_of(:book_id) }
  
  describe "associations" do
    it { should belong_to(:club) }
    it { should belong_to(:book) }
  end
end
