# == Schema Information
#
# Table name: partners
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  collaborator_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  brith_date      :date
#  email           :string(255)
#  street          :string(255)
#  number          :string(255)
#  hood            :string(255)
#  cep             :string(255)
#  gender          :string(255)
#  birth_date      :date
#  fone1           :string(255)
#  fone2           :string(255)
#

require 'spec_helper'

describe Partner do
  let(:collaborator) { FactoryGirl.create(:collaborator) }

  before { @partner = collaborator.partners.build(name: 'Sample Partner') }

  subject { @partner }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:street) }
  it { should respond_to(:number) }
  it { should respond_to(:hood) }
  it { should respond_to(:cep) }
  it { should respond_to(:gender) }
  it { should respond_to(:birth_date) }

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
