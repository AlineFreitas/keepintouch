require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { "Keepintouch.net.br -"}

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',
                              :text => 'Seja Bem-Vindo') }

    it { should have_selector('title',
                              :text => full_title('')) }

    it { should_not have_selector('title',
                                  :text => '- Home') }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',
                              :text => "Sobre o Keepintouch") }

    it { should have_selector('title',
                              :text => full_title('About')) }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',
                              :text => "Perguntas Frequentes") }

    it {should have_selector('title',
                             :text => full_title('FAQ')) }
  end
end
