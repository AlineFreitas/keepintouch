# == Schema Information
#
# Table name: partners
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  collaborator_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe Partner do
  let(:collaborator) { FactoryGirl.create(:collaborator) }

  before { @partner = collaborator.partners.build(name: 'Sample Partner') }

  subject { @partner }

  it { should respond_to(:name) }
  it { should respond_to(:collaborator_id) }
  it { should respond_to(:collaborator) }
  its(:collaborator) { should ==collaborator }

  describe "accessible attributes" do
    it "should not allow access to collaborator_id" do
      expect do
        Partner.new(collaborator_id: collaborator.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "when collaborator_id is not present" do
    before { @partner.collaborator_id = nil }
    it { should_not be_valid }
  end
end
