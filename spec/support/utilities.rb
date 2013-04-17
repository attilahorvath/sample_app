include ApplicationHelper

def valid_user
  fill_in "Name", with: "Example User"
  fill_in "Email", with: "user@example.com"
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in_request(user)
  # post session_path(email: user.email, password: user.password)
  cookies[:remember_token] = user.remember_token
end

RSpec::Matchers.define :have_header do |header|
  match do |page|
    page.should have_selector('h1', text: header)
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_no_error_message do
  match do |page|
    page.should have_no_selector('div.alert.alert-error')
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_no_success_message do
  match do |page|
    page.should have_no_selector('div.alert.alert-success')
  end
end
