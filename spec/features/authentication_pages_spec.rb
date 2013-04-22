require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_header('Sign in') }
    it { should have_title(full_title('Sign in')) }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title(full_title('Sign in')) }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should have_no_error_message }
      end
    end
  end

  describe "while not signed in" do
    before { visit root_path }

    it { should_not have_link('Users') }
    it { should_not have_link('Profile') }
    it { should_not have_link('Settings') }
    it { should_not have_link('Sign out') }
  end
  
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    it { should have_title(full_title(user.name)) }

    it { should have_link('Users', href: users_path) }
    it { should have_link('Profile', href: user_path(user)) }
    it { should have_link('Settings', href: edit_user_path(user)) }
    it { should have_link('Sign out', href: signout_path) }

    it { should_not have_link('Sign in', href: signin_path) }

    describe "followed by signout" do
      before { click_link "Sign out" }
      it { should have_link('Sign in') }
    end
  end

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_title(full_title('Edit user'))
          end

          describe "when sigining in again" do
            before do
              click_link "Sign out"
              sign_in user
            end

            it "should render the default (profile) page" do
              page.should have_title(full_title(user.name))
            end
          end
        end
      end

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title(full_title('Sign in')) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title(full_title('Sign in')) }
        end

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_title(full_title('Sign in')) }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_title(full_title('Sign in')) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title('Edit user')) }
      end
    end
  end
end
