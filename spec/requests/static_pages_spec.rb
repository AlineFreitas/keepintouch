#coding: utf-8
require 'spec_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Sobre"
    page.should have_selector 'title', text: full_title('About')
    click_link "FAQ"
    page.should # fill in
    click_link "Início"
    click_link "Log in now!"
    page.should have_selector 'title', text: full_title('')
    click_link "Keepintouch"
    page.should have_selector 'title', text: full_title('')
  end


  describe "Home page" do
    let(:heading)    { 'Seja Bem-Vindo' }
    let(:page_title) { '' }

    before { visit root_path }

    it_should_behave_like "all static pages"
    it { should_not have_selector('title',
                                  :text => 'Home') }
  end

  describe "About page" do
    let(:heading)    { 'Sobre o Keepintouch' }
    let(:page_title) { 'About' }

    before { visit about_path }
    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    let(:heading)    { 'Perguntas Frequentes' }
    let(:page_title) { 'FAQ' }

    before { visit help_path }

    it_should_behave_like "all static pages"
  end
end
