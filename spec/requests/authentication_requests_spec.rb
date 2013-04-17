require 'spec_helper'

describe "Authentication Requests" do

  subject { response }

  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do
        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { should redirect_to(signin_path) }
        end
      end
    end

    describe "as signed-in user" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in_request user }

      describe "submitting a GET request to the Users#new action" do
        before { get new_user_path }
        specify { should redirect_to(root_path) }
      end

      describe "submitting a POST request to the Users#create action" do
        before { post users_path }
        specify { should redirect_to(root_path) }
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in_request user }

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { should redirect_to(root_path) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in_request non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { should redirect_to(root_path) }
      end
    end

    describe "as admin user" do
      let(:user) { FactoryGirl.create(:user) }

      before { sign_in_request user }

      describe "submitting a DELETE request to the Users#destroy action for the admin's own user" do
        before { delete user_path(user) }
        specify { should redirect_to(root_path) }
      end
    end
  end
end
