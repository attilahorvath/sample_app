require 'spec_helper'

describe "Micropost pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_error_message }
      end
    end

    describe "with valid information" do
      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    describe "as correct user" do
      before do
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as another user" do
      let(:another_user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: another_user)
        visit root_path
      end

      it { should_not have_content("delete") }
    end
  end

  describe "sidebar micropost counts" do
    describe "0 microposts" do
      before { visit root_path }

      it { should have_content("0 microposts") }
    end

    describe "1 micropost" do
      before do
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end

      it { should have_content("1 micropost") }
    end

    describe "2 microposts" do
      before do
        FactoryGirl.create(:micropost, user: user)
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end

      it { should have_content("2 microposts") }
    end
  end
end
