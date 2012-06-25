require 'spec_helper'

describe "StaticPages" do
  #base_title = "Keepintouch.net.br - "

  describe "Home page" do
    it "should have the content 'Seja Bem-Vindo'" do
      visit '/static_pages/home'
      page.should have_content('Seja Bem-Vindo')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "Keepintouch.net.br - Home")
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
                        :text => "Keepintouch.net.br - About")
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
                        :text => "Keepintouch.net.br - FAQ")
    end
  end
end
