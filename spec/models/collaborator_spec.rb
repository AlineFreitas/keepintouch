#coding:utf-8
# == Schema Information
#
# Table name: collaborators
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

require 'spec_helper'

describe Collaborator do
  before do
    @collaborator = Collaborator.new(name: "Example collaborator",
                                     email: "collaborator@example.com",
                                     password: "foobar",
                                     password_confirmation: "foobar")
  end

  subject { @collaborator }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:partners) }
  it { should respond_to(:feed) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { @collaborator.toggle!(:admin) }

    it { should be_admin }
  end

  describe "when name is'nt present" do
    before { @collaborator.name = "" }
    it { should_not be_valid}
  end

  describe "when email is'nt present" do
    before { @collaborator.email = "" }
    it { should_not be_valid}
  end

  describe "when name is too long" do
    before { @collaborator.name="e"*51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[collaborator@foo,com collaborator_at_foo.org example.collaborator@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @collaborator.email = invalid_address
        @collaborator.should_not be_valid
      end      
    end
  end
  
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @collaborator.email = mixed_case_email
      @collaborator.save
      @collaborator.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[collaborator@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @collaborator.email = valid_address
        @collaborator.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      collaborator_with_same_email = @collaborator.dup
      collaborator_with_same_email.email = @collaborator.email.upcase
      collaborator_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @collaborator.password = @collaborator.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @collaborator.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @collaborator.save }

    let(:found_collaborator) { Collaborator.find_by_email(@collaborator.email) }

    describe "with valid password" do
      it { should == found_collaborator.authenticate(@collaborator.password) }
    end

    describe "with invalid password" do
      let(:collaborator_for_invalid_password) { found_collaborator.authenticate("invalid") }

      it { should_not == collaborator_for_invalid_password }
      specify { collaborator_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @collaborator.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "partner associations" do

    before { @collaborator.save }

    let!(:first_partner) do 
      FactoryGirl.create(:partner, collaborator: @collaborator, name: 'Alice')
    end
    let!(:last_partner) do
      FactoryGirl.create(:partner, collaborator: @collaborator, name: 'Zélia')
    end

    it "should have the right partners in the right order" do
      @collaborator.partners.should == [first_partner, last_partner]
    end
    
    it "should destroy associated partners" do
      partners = @collaborator.partners
      @collaborator.destroy
      partners.each do |partner|
        Partner.find_by_id(partner.id).should be_nil
      end
    end

    describe "status" do
      let(:someonelse_partner) do
        FactoryGirl.create(:partner, collaborator: FactoryGirl.create(:collaborator))
      end

      its(:feed) { should include(first_partner) }
      its(:feed) { should include(last_partner) }
      its(:feed) { should_not include(someonelse_partner) }
    end
  end
end
