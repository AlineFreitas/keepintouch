# == Schema Information
#
# Table name: collaborators
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
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
  it { should respond_to(:authenticate) }

  it { should be_valid }

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
end
