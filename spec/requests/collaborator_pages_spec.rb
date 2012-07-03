#coding: utf-8
require 'spec_helper'

describe "CollaboratorPages" do
  subject { page }

  describe "profile page" do
    let(:collaborator) { FactoryGirl.create(:collaborator) }
    let!(:partner1) { FactoryGirl.create(:partner, collaborator: collaborator, name: "Foo") }
    let!(:partner2) { FactoryGirl.create(:partner, collaborator: collaborator, name: "Bar") }

    before do
      sign_in collaborator
      visit collaborator_path(collaborator)
    end


    it { should have_selector('h1',    text: collaborator.name) }
    it { should have_selector('title', text: collaborator.name) }
    
    describe "partners" do
      it { should have_content(partner1.name) }
      it { should have_content(partner2.name) }
      it { should have_content(collaborator.partners.count) }
    end
  end

  describe "index" do
    let(:collaborator) { FactoryGirl.create(:collaborator) }
    let(:admin) { FactoryGirl.create(:admin) }

    before(:all) { 30.times { FactoryGirl.create(:collaborator) } }
    after(:all)  { Collaborator.delete_all }

    describe "as a non-admin user" do
      before(:each) do
        sign_in collaborator
        visit collaborators_path
      end

      it { should_not have_selector('title', text: 'Lista de Colaboradores') }
      it { should_not have_selector('h1',    text: 'Todos Colaboradores') }
      it { should have_selector('h1'), text: 'Atividades Recentes'}
      it { should have_selector('title'), text: 'Keepintouch.net.br'}
    end

    describe "as an admin user" do
      before do
        sign_in admin
        visit collaborators_path
      end

      describe "pagination" do

        it { should have_selector('div.pagination') }

        it "should list each collaborator" do
          Collaborator.paginate(page: 1).each do |collaborator|
            page.should have_selector('li', text: collaborator.name)
          end
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin collaborator" do
        let(:admin) { FactoryGirl.create(:admin) }

        before do
          sign_in admin
          visit collaborators_path
        end

        it { should have_link('delete', href: collaborator_path(Collaborator.first)) }

        it "should be able to delete another collaborator" do
          expect { click_link('delete') }.to change(Collaborator, :count).by(-1)
        end
        it { should_not have_link('delete', href: collaborator_path(admin)) }
      end
    end
  end

  describe "new collaborator page" do
    describe "as a non-admin user" do
      let(:collaborator) { FactoryGirl.create(:collaborator) }

      before do
        sign_in collaborator
        get new_collaborator_path
      end
      
      specify { response.should redirect_to(root_path) }
    end

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }

      before (:each) do
        sign_in admin
        visit new_collaborator_path
      end
      
      let(:submit) { "Cadastrar" }

      it { should have_selector('h1',    text: 'Cadastrar Colaborador') }
      it { should have_selector('title', text: 'Cadastrar Colaborador') }

      describe "with invalid information" do
        it "should not create a collaborator" do
          expect { click_button submit }.not_to change(Collaborator, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "collaborator[name]",         with: "Example User"
          fill_in "collaborator[email]",        with: "collaborator@example.com"
          fill_in "collaborator[fone1]",                 with: "11111111"
          fill_in "collaborator[password]",              with: "foobar"
          fill_in "collaborator[password_confirmation]", with: "foobar"
        end

        it "should create a collaborator" do
          expect { click_button submit }.to change(Collaborator, :count).by(1)
        end
      end
    end
  end

  describe "edit" do
    let(:collaborator) { FactoryGirl.create(:collaborator) }

    before do
      sign_in collaborator
      visit edit_collaborator_path(collaborator)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Editar dados Colaborador") }
      it { should have_link('alterar gravatar', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Salvar" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "collaborator[name]",             with: new_name
        fill_in "collaborator[email]",            with: new_email
        fill_in "collaborator[password]",         with: collaborator.password
        fill_in "collaborator[password_confirmation]", with: collaborator.password
        click_button "Salvar"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { collaborator.reload.name.should  == new_name }
      specify { collaborator.reload.email.should == new_email }
    end
  end
end
