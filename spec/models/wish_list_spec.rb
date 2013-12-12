require 'spec_helper'

describe WishList do
  it { should validate_presence_of(:book_id) }
  it { should validate_presence_of(:user_id) }

  it { should allow_mass_assignment_of(:book_id) }
  it { should allow_mass_assignment_of(:user_id) }

  describe "associations" do
    it { should belong_to(:user)}
    it { should belong_to(:book)}
  end
end
