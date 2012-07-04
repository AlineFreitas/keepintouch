#coding: utf-8
require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link "Início" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:collaborator) { FactoryGirl.create(:collaborator) }
      before { valid_signin(collaborator) }

      it { should have_selector('title', text: collaborator.name) }
      
      it { should have_link('Parceiros',    href: partners_path) }
      it { should have_link('Profile', href: collaborator_path(collaborator)) }
      it { should have_link('Settings', href: edit_collaborator_path(collaborator)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should_not have_link('Colaboradores', href: collaborators_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in collaborators" do
      let(:collaborator) { FactoryGirl.create(:collaborator) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_collaborator_path(collaborator)
          fill_in "Email",    with: collaborator.email
          fill_in "Password", with: collaborator.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_selector('title', text: 'Editar dados Colaborador')
          end
        end
      end
      
      describe "in the Collaborators controller" do
        let(:collaborator) { FactoryGirl.create(:collaborator) }

        describe "visiting the edit page" do
           before { visit edit_collaborator_path(collaborator) }
           it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put collaborator_path(collaborator) }
          specify { response.should redirect_to(signin_path) }
        end
      
        describe "visiting the collaborator index" do
          before { visit collaborators_path }
          it { should have_selector('title', text: 'Sign in') }
        end
      end
      
      describe "in the Partners controller" do

        describe "submitting to the create action" do
          before { post partners_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete partner_path(FactoryGirl.create(:partner)) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end


    describe "as wrong collaborator" do
      let(:collaborator) { FactoryGirl.create(:collaborator) }
      let(:wrong_collaborator) { FactoryGirl.create(:collaborator, email: "wrong@example.com") }
      before { sign_in collaborator }

      describe "visiting Collaborators#edit page" do
        before { visit edit_collaborator_path(wrong_collaborator) }
        it { should_not have_selector('title', text: full_title('Edit collaborator')) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put collaborator_path(wrong_collaborator) }
        specify { response.should redirect_to(root_path) }
      end
    end
    
    describe "as non-admin collaborator" do
      let(:collaborator) { FactoryGirl.create(:collaborator) }
      let(:non_admin) { FactoryGirl.create(:collaborator) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete collaborator_path(collaborator) }
        specify { response.should redirect_to(root_path) }        
      end
    end
  end
end
