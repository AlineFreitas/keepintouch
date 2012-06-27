require 'spec_helper'

describe "CollaboratorPages" do
  subject { page }

  describe "profile page" do
    let(:collaborator) { FactoryGirl.create(:collaborator) }
    before { visit collaborator_path(collaborator) }

    it { should have_selector('h1',    text: collaborator.name) }
    it { should have_selector('title', text: collaborator.name) }
  end

  describe "new collaborator page" do
    before { visit new_collaborator_path }
    
    let(:submit) { "Cadastrar" }

    it { should have_selector('h1',    text: 'Cadastrar Colaborador') }
    it { should have_selector('title', text: 'Cadastrar Colaborador') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Collaborator, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a collaborator" do
        expect { click_button submit }.to change(Collaborator, :count).by(1)
      end
    end
  end
end
