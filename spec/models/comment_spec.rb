require 'spec_helper'

describe Comment do
  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:parent_id) }
  it { should allow_mass_assignment_of(:post_id) }
  it { should allow_mass_assignment_of(:user_id) }
  
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:parent_id) }
  it { should validate_presence_of(:post_id) }
  it { should validate_presence_of(:user) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should belong_to(:parent_comment) }
    it { should have_many(:children_comments) }
  end
end
