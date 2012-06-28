require 'spec_helper'

describe "Partner pages" do

  subject { page }

  let(:collaborator) { FactoryGirl.create(:collaborator) }
  before { sign_in collaborator }

  describe "partner creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a partner" do
        expect { click_button "Post" }.should_not change(Partner, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'partner_name', with: "Lorem ipsum" }
      it "should create a partner" do
        expect { click_button "Post" }.should change(Partner, :count).by(1)
      end
    end
  end
  
  describe "partner destruction" do
    before { FactoryGirl.create(:partner, collaborator: collaborator) }

    describe "as correct collaborator" do
      before { visit root_path }

      it "should delete a partner" do
        expect { click_link "delete" }.should change(Partner, :count).by(-1)
      end
    end
  end
end
