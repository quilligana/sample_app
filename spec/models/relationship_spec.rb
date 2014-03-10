require 'spec_helper'

describe Relationship do
  
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }
  

  subject { relationship }

  it { should be_valid }

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }
    its(:follower) { should eq follower }
    its(:followed) { should eq followed }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end

  describe "when a user is deleted" do
    before do
      follower.save!
      followed.save!
      relationship.save!
    end
    it "should destroy associated relationships" do
      relationships = follower.relationships.to_a
      expect(relationships).not_to be_empty
      followed.destroy!
      relationships.each do |relationship|
        expect(Relationship.where(id: relationship.id)).to be_empty
      end
      # expect(User.where(id: relationship.followed_id).to be_empty)
      # expect(relationships).not_to be_empty
      # expect(relationship).to be_nil
    end
  end

end
