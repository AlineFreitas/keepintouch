require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { "Keepintouch.net.br -"}

  describe "Home page" do
    it "should have the content 'Seja Bem-Vindo'" do
      visit '/static_pages/home'
      page.should have_content('Seja Bem-Vindo')
    end

   it "should have the h1 'Seja Bem-Vindo'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Seja Bem-Vindo')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "Keepintouch.net.br")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '- Home')
    end
  end

  describe "About page" do
    it "should have the content 'Sobre o Keepintouch'" do
      visit '/static_pages/about'
      page.should have_content('Sobre o Keepintouch')
    end

    it "should have the title 'About'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                        :text => "#{base_title} About")
    end
  end

  describe "Help page" do
    it "should have the content 'Perguntas Frequentes'" do
      visit '/static_pages/help'
      page.should have_content('Perguntas Frequentes')
    end

    it "should have the title 'FAQ'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                        :text => "#{base_title} FAQ")
    end
  end
end
